//
//  TodoUserListViewModel.swift
//  MVVM
//
//  Created by Mohamed El-Taweel on 9/14/20.
//  Copyright © 2020 Learning. All rights reserved.
//

import Foundation
import RxSwift
import RxOptional
import Moya

class TodoUserListViewModel: TodoUserListViewModelProtocol{
       
    var users: Observable<[TodoUserTableCellViewModel]> {createUsersObservable()}
    var shouldShowLoading: Observable<Bool> {createLoadingObservable()}
    var shouldShowErrorMessage: Observable<String> {createErrorObservable()}
    var shouldBrowseUserTodos: Observable<Int> {createBrowserUserTodosObservable()}
    var selectedUser: PublishSubject<Int>
    var jsonTransformer: CodableTransformer
    private var networkRouter: MoyaProvider<TodoUserListNetworkRouter>
    private var loadingEvent: PublishSubject<Bool>
    private var browseUserTodosEvent: PublishSubject<User>
    private var errorEvent: PublishSubject<String>
    private var response: Variable<UserListResponse?>
    private var disposeBag: DisposeBag
    
    init() {
        response = Variable(nil)
        loadingEvent = PublishSubject()
        browseUserTodosEvent = PublishSubject()
        errorEvent = PublishSubject()
        selectedUser = PublishSubject()
        networkRouter =  MoyaProvider<TodoUserListNetworkRouter>(plugins: [NetworkLoggerPlugin()])
        jsonTransformer = CodableTransformer()
        disposeBag = DisposeBag()
    }
    
    func getUsersList() {
        loadingEvent.onNext(true)
        networkRouter
            .rx
            .request(.TodoUserList)
            .map(mapMoyaResponse(from:))
            .asObservable()
            .do(onNext: { [weak self] _ in self?.loadingEvent.onNext(false)},onError: handleOperationError(with:))
            .bind(to: response)
            .disposed(by: disposeBag)
        
            
    }
    
    private func handleOperationError(with error: Error){
        guard let operationError = error as? TodoUserListError else{
            errorEvent.onNext(TodoUserListError.ServerError.localizedDescription)
            return
        }
        errorEvent.onNext(operationError.localizedDescription)
    }
    
    
    private func mapMoyaResponse(from response: Response)throws ->UserListResponse{
        guard let responseModel = jsonTransformer.decodeObject(from: response.data, to: UserListResponse.self) else{ throw TodoUserListError.ServerError }
        return responseModel
        
    }
    
    private func createUsersObservable()->Observable<[TodoUserTableCellViewModel]>{
        return response
            .asObservable()
            .filterNil()
            .map{ $0.map({TodoUserTableCellViewModel(name: $0.username) }) }
    }
    
    private func createLoadingObservable()->Observable<Bool>{
        return loadingEvent
            .asObservable()
    }
    
    private func createBrowserUserTodosObservable()->Observable<Int>{
        return selectedUser
            .asObservable()
            .map{ [weak self] in self?.response.value?[$0].id }
            .filterNil()
    }
    
    private func createErrorObservable()->Observable<String>{
        return errorEvent
            .asObservable()
    }
    
}
