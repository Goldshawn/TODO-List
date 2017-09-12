//
//  modelForApp.swift
//  TODO List
//
//  Created by Shalom Owolabi on 12/09/2017.
//  Copyright © 2017 NextInc. All rights reserved.
//

import Foundation

class Todo {
    
    private var _todoName: String!
    private var _pendingArray = ["I'm The first of my name", "Who are You", "Fido dido", "And your name is?", "Schambach is asleep"]
    private var _doneArray = [String]()
    
    let myUserDefaults = UserDefaults.standard
    
    
    var todoName: String {
        if _todoName == nil{
            _todoName = ""
        }
        return _todoName
    }
    
//    var pendingArray: [String] {
//        return _pendingArray
//    }
//    
//    var doneArray: [String] {
//        return _doneArray
//    }
    
    init() {
        
        myUserDefaults.set(_pendingArray, forKey: "PendingArray")
        myUserDefaults.set(_doneArray, forKey: "DoneArray")
        
    }
    
    func addNewTodo(_ todo: String) {
        
        _pendingArray.append(todo)
        myUserDefaults.set(_pendingArray, forKey: "PendingArray")
    }
    
    func deleteFromPending(_ indexOf: Int){
        
        _pendingArray.remove(at: indexOf)
        
    }
    
    
    func moveToDoneArray(indexOf: Int) {
        
        _doneArray.append(_pendingArray[indexOf])
        _pendingArray.remove(at: indexOf)
        
        
    }
}
