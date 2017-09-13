//
//  modelForApp.swift
//  TODO List
//
//  Created by Shalom Owolabi on 12/09/2017.
//  Copyright © 2017 NextInc. All rights reserved.
//

import UIKit
import CoreData

class Model {

    
    enum destinationEntity: String{
        case toDone = "Done"
        case todo = "Todo"
    }
    
    func save(_ name: String, _ theArray: [NSManagedObject], _ Where: destinationEntity) ->[NSManagedObject] {
        
        var localArray = theArray
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            // 1
            let managedContext =
                appDelegate.persistentContainer.viewContext
            
            // 2
            let entity =
                NSEntityDescription.entity(forEntityName: Where.rawValue,
                                           in: managedContext)!
            
            let todoItem = NSManagedObject(entity: entity,
                                           insertInto: managedContext)
            
            // 3
            todoItem.setValue(name, forKeyPath: "title")
            
            // 4
            do {
                try managedContext.save()
                
                localArray.append(todoItem)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        
        return localArray
    }
    
    func kindlyDelete(_ indexOf: Int, _ theArray: [NSManagedObject])  -> [NSManagedObject]{
        // Delete the row from the data source
        
        var localArray = theArray
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            managedContext.delete(localArray[indexOf] as NSManagedObject)
            
            localArray.remove(at: indexOf)
            
            do {
                try managedContext.save()
                
            } catch let error as NSError {
                
                print("Could not save. \(error), \(error.userInfo)")
                
            }
        }
        return localArray
    }
    
    func goFetch(_ Where: destinationEntity)  -> [NSManagedObject] {
        var localArray = [NSManagedObject]()
        
        if let appDelegate =
            UIApplication.shared.delegate as? AppDelegate {
            let managedContext =
                appDelegate.persistentContainer.viewContext
            
            //2
            let fetchRequest =
                NSFetchRequest<NSManagedObject>(entityName: Where.rawValue)
            
            //3
            do {
                
                localArray = try managedContext.fetch(fetchRequest)
                
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }

        }
        return localArray
    }
    
}
