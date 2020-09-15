//
//  UserTodoListProtocol.swift
//  TodoVIPER
//
//  Created by Mohamed El-Taweel on 9/9/20.
//  Copyright © 2020 Learning. All rights reserved.
//

import Foundation
import RxSwift

protocol UserTodoListViewModelProtocol{
    var todos: Observable<[UserTodoCellViewModel]>{get}
    var shouldShowLoading: Observable<Bool>{get}
    var shouldShowErrorMessage: Observable<String>{get}
    func getTodoList()    
}


