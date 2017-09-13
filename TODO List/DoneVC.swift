//
//  DoneVC.swift
//  TODO List
//
//  Created by Shalom Owolabi on 12/09/2017.
//  Copyright © 2017 NextInc. All rights reserved.
//

import UIKit

class DoneVC: UITableViewController {

    var doneArray = UserDefaults.standard.array(forKey: "DoneArray")
    
    let todo = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
         self.navigationItem.title = "All Done"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if doneArray != nil {
            
            return (doneArray!.count)
            
        }else{
            return 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UserDefaults.standard.synchronize()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "doneCell", for: indexPath) as? forTest{
            
             // Configure the cell...
            if doneArray != nil{
                cell.todoLabel.text = doneArray![indexPath.row] as? String
            }

            return cell
            
        }else {
            return UITableViewCell()
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            self.doneArray?.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            
        }
        todo.editDoneDefaults(doneArray! as! Array<String>)
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(
            title: "Are you done?",
            message: "are you really sure You are Done?",
            preferredStyle: .alert)
        
        // Add a "cancel" button to the alert. This one doesn't need a handler
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            
            let backToPending = self.doneArray?[indexPath.row]
            
            self.todo.SwitchLocal(backToPending as! String, .pending)
            self.doneArray?.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            
            self.todo.editDoneDefaults(self.doneArray! as! Array<String>)
            
        }))
        
        // Present the alert to the user
        self.present(alert, animated: true, completion: nil)
    }

}
