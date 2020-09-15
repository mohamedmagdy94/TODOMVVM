//
//  TodoUserListProtocol.swift
//  VIPER
//
//  Created by Mohamed El-Taweel on 9/8/20.
//  Copyright © 2020 Learning. All rights reserved.
//

import Foundation
import RxSwift

protocol TodoUserListViewModelProtocol {
    var users: Observable<[TodoUserTableCellViewModel]>{get}
    var shouldShowLoading: Observable<Bool>{get}
    var shouldShowErrorMessage: Observable<String>{get}
    var shouldBrowseUserTodos: Observable<Int>{get}
    var selectedUser: PublishSubject<Int>{get}
    func getUsersList()
    
}

protocol TodoUserListViewProtocol {
    func showLoading()
    func hideLoading()
    func showError(with message: String)
}
