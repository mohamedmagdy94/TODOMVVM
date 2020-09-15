//
//  UserTodoTableViewCell.swift
//  VIP
//
//  Created by Mohamed El-Taweel on 9/2/20.
//  Copyright © 2020 Learning. All rights reserved.
//

import UIKit

class UserTodoTableViewCell: UITableViewCell {

    static var IDENTIFIER = "USER_TODO_CELL"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    func config(with viewModel: UserTodoCellViewModel){
        self.titleLabel.text = viewModel.title
        self.bodyLabel.text = viewModel.body
    }

}
