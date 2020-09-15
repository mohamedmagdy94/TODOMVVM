//
//  UserTodoListError.swift
//  VIP
//
//  Created by Mohamed El-Taweel on 9/3/20.
//  Copyright © 2020 Learning. All rights reserved.
//

import Foundation

enum UserTodoListError:Error{
    case Connectivity
    case ServerError
    
    
    var localizedDescription: String{
        switch self {
        case .Connectivity:
            return "Internet Problem"
        case .ServerError:
            return "Server Error"
        }
    }
}
