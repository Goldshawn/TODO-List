//
//  TableCellForTODO.swift
//  TODO List
//
//  Created by Shalom Owolabi on 12/09/2017.
//  Copyright © 2017 NextInc. All rights reserved.
//

import UIKit

class TableCellForTODO: UITableViewCell {

    @IBOutlet weak var todoLabel: UILabel!
    
    var todo: Todo!
    
    func configureCell (_ todo: Todo){
        self.todo = todo
        
        todoLabel.text = self.todo.todoName
    }

}
