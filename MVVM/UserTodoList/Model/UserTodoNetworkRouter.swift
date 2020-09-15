//
//  UserTodoNetworkRouter.swift
//  VIP
//
//  Created by Mohamed El-Taweel on 9/3/20.
//  Copyright © 2020 Learning. All rights reserved.
//

import Foundation
import Moya

enum UserTodoNetworkRouter {
    case UserTodoList(request: UserTodoListRequest)
}

extension UserTodoNetworkRouter: TargetType {
    var sampleData: Data {
        switch self {
        case .UserTodoList:
            return Data()
        }
    }
    
    var headers: [String : String]? {
        return [String:String]()
    }
    
    var baseURL: URL { return URL(string: "https://jsonplaceholder.typicode.com")! }
    var path: String {
        switch self {
        case .UserTodoList:
            return "/posts"
        }
    }
    var method: Moya.Method {
        switch self {
        case .UserTodoList:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .UserTodoList(let request):
            return .requestParameters(parameters: ["userId":"\(request.userId)"], encoding: URLEncoding.queryString)
        }
    }
    
}
