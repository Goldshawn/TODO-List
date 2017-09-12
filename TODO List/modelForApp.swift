//
//  modelForApp.swift
//  TODO List
//
//  Created by Shalom Owolabi on 12/09/2017.
//  Copyright © 2017 NextInc. All rights reserved.
//

import Foundation

class Todo {
    
    enum toWhere: String {
        case pending = "pending"
        case done = "done"
    }
    
    private var almostThere = [String]()
    private var _todoName: String!
    
    let myUserDefaults = UserDefaults.standard
    
    
    var todoName: String {
        if _todoName == nil{
            _todoName = ""
        }
        return _todoName
    }
    
    
    func editPendingDefaults(_ currentPending: Array<Any>) {
        
        myUserDefaults.set(currentPending, forKey: "PendingArray")
        
    }
    
    func editDoneDefaults(_ currentPending: Array<Any>) {
        
        myUserDefaults.set(currentPending, forKey: "DoneArray")
        
    }
    
    func SwitchLocal(_ gettingDone: String, _ switchCase: toWhere) {
        
        if switchCase == .done {
            
            almostThere.append(gettingDone)
            editDoneDefaults(almostThere)
            
        } else if switchCase == .pending {
            
            almostThere.append(gettingDone)
            editPendingDefaults(almostThere)
        }
        
    }
}
