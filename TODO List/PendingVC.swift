//
//  PendingVC.swift
//  TODO List
//
//  Created by Shalom Owolabi on 12/09/2017.
//  Copyright © 2017 NextInc. All rights reserved.
//

import UIKit

class PendingVC: UITableViewController {

    var pendingArray = UserDefaults.standard.array(forKey: "PendingArray")
    
    let todo = Todo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.leftBarButtonItem = self.editButtonItem
         self.navigationItem.title = "Pending Todo"
        
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if pendingArray != nil {
            
        return (pendingArray!.count)
            
        }else{
            return 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "pendingCell", for: indexPath) as? TableCellForTODO{
            
            // Configure the cell...
            if pendingArray != nil{
                cell.todoLabel.text = pendingArray![indexPath.row] as? String
            }
            
            return cell
        }else {
            
            return UITableViewCell()
        }

    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            
            self.pendingArray?.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            
        }
        todo.editPendingDefaults((pendingArray)!)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(
            title: "Are you done?",
            message: "are you really sure You are Done?",
            preferredStyle: .alert)
        
        // Add a "cancel" button to the alert. This one doesn't need a handler
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            
            let getDone = self.pendingArray?[indexPath.row]
            
            self.todo.SwitchLocal(getDone as! String, .done)
            self.pendingArray?.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            
            
            self.todo.editPendingDefaults(self.pendingArray!)
            
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
                self.addNewToDoItem(title)
            }
        }))
        
        // Present the alert to the user
        self.present(alert, animated: true, completion: nil)
        
    }
        
    
    private func addNewToDoItem(_ title: String)
    {
        // The index of the new item will be the current item count
        let newIndex: Int
        
        if pendingArray != nil {
            newIndex = pendingArray!.count
        }else{
            newIndex = 0
        }
        
        // Create new item and add it to the todo items list
        
        self.pendingArray?.append(title)
        
        // Tell the table view a new row has been created
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .automatic)
        tableView.endUpdates()
        
        todo.editPendingDefaults((pendingArray!))
        
    }


}
