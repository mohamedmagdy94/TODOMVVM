//
//  TodoUserListNetworkRouter.swift
//  TodoVIPER
//
//  Created by Mohamed El-Taweel on 9/8/20.
//  Copyright © 2020 Learning. All rights reserved.
//

import Foundation

import Moya

enum TodoUserListNetworkRouter {
    case TodoUserList
}

extension TodoUserListNetworkRouter: TargetType {
    var sampleData: Data {
        switch self {
        case .TodoUserList:
            return Data()
        }
    }
    
    var headers: [String : String]? {
        return [String:String]()
    }
    
    var baseURL: URL { return URL(string: "https://jsonplaceholder.typicode.com")! }
    var path: String {
        switch self {
        case .TodoUserList:
            return "/users"
        }
    }
    var method: Moya.Method {
        switch self {
        case .TodoUserList:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .TodoUserList: // Send no parameters
            return .requestPlain
        }
    }
    
}
