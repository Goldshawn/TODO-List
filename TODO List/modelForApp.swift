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
    
    private let myUserDefaults = UserDefaults.standard
    
    var todoName: String {
        if _todoName == nil{
            _todoName = ""
        }
        return _todoName
    }
    
    init() {
        UserDefaults.standard.set(["My life"], forKey: "PendingArray")
    }
    
    func editPendingDefaults(_ currentPending: Array<Any>) {
        
//        var tempPendingArray = UserDefaults.standard.array(forKey: "PendingArray")
//        tempPendingArray?.append(currentPending)
        
        myUserDefaults.set(currentPending, forKey: "PendingArray")
        
    }
    
    func editDoneDefaults(_ currentDone: Array<Any>) {
        
        var tempDoneArray = UserDefaults.standard.array(forKey: "DoneArray")
        tempDoneArray?.append(currentDone)
        
        myUserDefaults.set(tempDoneArray, forKey: "DoneArray")
        
    }
    
    func SwitchLocal(_ gettingDone: String, _ switchCase: toWhere) {
        
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
        
    }
}

class model {
    
    private var _todoName: String!
    
    private var _almostThere = [String]()
    
    enum toWhere: String {
        case pending = "pending"
        case done = "done"
    }
    
    var todoName: String {
        if _todoName == nil{
            _todoName = ""
        }
        return _todoName
    }
    
    private let myUserDefaults = UserDefaults.standard
    
    func editPendingDefaults(_ currentPending: Array<String>) {
        
        myUserDefaults.set(currentPending, forKey: "PendingArray")
        
    }
    
    func editDoneDefaults(_ currentDone: Array<String>) {
        
        myUserDefaults.set(currentDone, forKey: "DoneArray")
        
    }
    
    func toSwitch(_ currentArray: Array<String>) {
        var tempDoneArray = UserDefaults.standard.array(forKey: "DoneArray")
        
        tempDoneArray?.append(currentArray)
        
        myUserDefaults.set(tempDoneArray, forKey: "DoneArray")
    }
    
    func SwitchLocal(_ gettingDone: String, _ switchCase: toWhere) {
        
        if switchCase == .done {
            
            _almostThere.append(gettingDone)
            editDoneDefaults(_almostThere)
            
        } else if switchCase == .pending {
            
            _almostThere.append(gettingDone)
            editPendingDefaults(_almostThere)
        }
        
    }
}
