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
    
    func moveToDoneArray(_ indexOf: Int) {
        
        _doneArray.append(_pendingArray[indexOf])
        _pendingArray.remove(at: indexOf)
        editPendingDefaults(_pendingArray)
        editDoneDefaults(_doneArray)
        
    }
}
