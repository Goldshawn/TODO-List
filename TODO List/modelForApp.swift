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
<<<<<<< HEAD
    
    private var almostThere = [String]()
    private var _todoName: String!
=======
>>>>>>> MightNotWork
    
    private var _todoName: String!
    
    private let myUserDefaults = UserDefaults.standard
    private var almostThere = [String]()
    
    var todoName: String {
        if _todoName == nil{
            _todoName = ""
        }
        return _todoName
    }
    
    
    func editPendingDefaults(_ currentPending: Array<Any>) {
        
        var tempPendingArray = UserDefaults.standard.array(forKey: "PendingArray")
        tempPendingArray?.append(currentPending)
        
        myUserDefaults.set(tempPendingArray, forKey: "PendingArray")
        
    }
    
    func editDoneDefaults(_ currentDone: Array<Any>) {
        
        var tempDoneArray = UserDefaults.standard.array(forKey: "DoneArray")
        tempDoneArray?.append(currentDone)
        
        myUserDefaults.set(tempDoneArray, forKey: "DoneArray")
        
    }
    
    func SwitchLocal(_ gettingDone: String, _ switchCase: toWhere) {
<<<<<<< HEAD
        
        if switchCase == .done {
            
            almostThere.append(gettingDone)
            editDoneDefaults(almostThere)
            
        } else if switchCase == .pending {
            
            almostThere.append(gettingDone)
            editPendingDefaults(almostThere)
        }
=======
        
        if switchCase == .done {
            
            almostThere.append(gettingDone)
            editDoneDefaults(almostThere)
            
        } else if switchCase == .pending {
            
            almostThere.append(gettingDone)
            editPendingDefaults(almostThere)
        }
        
//        _doneArray.append(_pendingArray[indexOf])
//        _pendingArray.remove(at: indexOf)
//        editPendingDefaults(currentPending)
//        editDoneDefaults(currentDone)
>>>>>>> MightNotWork
        
    }
}
