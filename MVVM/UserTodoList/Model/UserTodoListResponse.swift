//
//  UserTodoListResponse.swift
//  VIP
//
//  Created by Mohamed El-Taweel on 9/3/20.
//  Copyright © 2020 Learning. All rights reserved.
//

import Foundation

// MARK: - UserTodoListResponseElement
struct UserTodoListResponseElement: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

typealias UserTodoListResponse = [UserTodoListResponseElement]
