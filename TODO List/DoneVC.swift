//
//  DoneVC.swift
//  TODO List
//
//  Created by Shalom Owolabi on 12/09/2017.
//  Copyright © 2017 NextInc. All rights reserved.
//

import UIKit
import CoreData

class DoneVC: UITableViewController {

    var doneItems: [NSManagedObject] = []
    
    let done = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
         self.navigationItem.title = "All Done"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        doneItems = done.goFetch(.toDone)
        tableView.reloadData(with: .automatic)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return (doneItems.count)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let doneItem = doneItems[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "doneCell", for: indexPath) as? forTest{
            
            // Configure the cell...
            cell.todoLabel.text = doneItem.value(forKeyPath: "title") as? String
            
            return cell
            
        }else {
            return UITableViewCell()
        }
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            // Delete the row from the data source
            self.doneItems = self.done.kindlyDelete(indexPath.row, doneItems)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
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
            
            let doneItem = self.doneItems[indexPath.row]
            if let title = doneItem.value(forKeyPath: "title") as? String{
                _ = self.done.save(title, self.doneItems, .todo)
            }
            
            self.doneItems = self.done.kindlyDelete(indexPath.row, self.doneItems)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.endUpdates()
            
        }))
        
        // Present the alert to the user
        self.present(alert, animated: true, completion: nil)
    }

}
extension UITableView {
    func reloadData(with animation: UITableViewRowAnimation) {
        reloadSections(IndexSet(integersIn: 0..<numberOfSections), with: animation)
    }
}
