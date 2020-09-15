//
//  TodoUserTableViewCell.swift
//  VIP
//
//  Created by Mohamed El-Taweel on 9/1/20.
//  Copyright © 2020 Learning. All rights reserved.
//

import UIKit

class TodoUserTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!

    static var IDENTIFIER = "TODO_USER_CELL"
    
    func config(with viewModel: TodoUserTableCellViewModel){
        userNameLabel.text = viewModel.name
    }
    

}
