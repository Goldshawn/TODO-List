//
//  PendingVC.swift
//  TODO List
//
//  Created by Shalom Owolabi on 12/09/2017.
//  Copyright © 2017 NextInc. All rights reserved.
//

import UIKit
import CoreData

class PendingVC: UITableViewController {
    
    var todoItems: [NSManagedObject] = []
    
    let todo = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.leftBarButtonItem = self.editButtonItem
         self.navigationItem.title = "Pending Todo"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        todoItems = todo.goFetch(.todo)
        
        tableView.reloadData(with: .automatic)
        
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return (todoItems.count)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let todoItem = todoItems[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "pendingCell", for: indexPath) as? TableCellForTODO{
            
            // Configure the cell...
                cell.todoLabel.text = todoItem.value(forKeyPath: "title") as? String
            
            return cell
        }else {
            
            return UITableViewCell()
        }

    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            self.todoItems = self.todo.kindlyDelete(indexPath.row, todoItems)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .bottom)
            tableView.endUpdates()
            
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(
            title: "Are you done?",
            message: "are you really sure You are Done?",
            preferredStyle: .alert)
        
        // Add a "cancel" button to the alert. This one doesn't need a handler
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            
            let todoItem = self.todoItems[indexPath.row]
            if let title = todoItem.value(forKeyPath: "title") as? String{
                 _ = self.todo.save(title, self.todoItems, .toDone)
            }
            
            self.todoItems = self.todo.kindlyDelete(indexPath.row, self.todoItems)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .right)
            tableView.endUpdates()
            
        }))
        
        // Present the alert to the user
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addToDo(_ sender: Any) {
        
        // Create an alert
        let alert = UIAlertController(
            title: "New to-do item",
            message: "Insert the title of the new to-do item:",
            preferredStyle: .alert)
        
        // Add a text field to the alert for the new item's title
        alert.addTextField(configurationHandler: nil)
        
        // Add a "cancel" button to the alert. This one doesn't need a handler
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Add a "OK" button to the alert. The handler calls addNewToDoItem()
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            if let title = alert.textFields?[0].text
            {
                self.todoItems = self.todo.save(title, self.todoItems, .todo)
            }
            
            let index = self.todoItems.count - 1
            // Tell the table view a new row has been created
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .top)
            self.tableView.endUpdates()
        }))
        
        // Present the alert to the user
        self.present(alert, animated: true, completion: nil)
        
    }

}
