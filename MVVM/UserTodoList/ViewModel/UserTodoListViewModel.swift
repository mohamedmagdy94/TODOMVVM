//
//  UserTodoListViewModel.swift
//  MVVM
//
//  Created by Mohamed El-Taweel on 9/15/20.
//  Copyright © 2020 Learning. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import RxOptional

class UserTodoListViewModel: UserTodoListViewModelProtocol {
    
    var todos: Observable<[UserTodoCellViewModel]>{createTodosObservable()}
    var shouldShowLoading: Observable<Bool>{ loadingEvent.asObservable() }
    var shouldShowErrorMessage: Observable<String> { errorEvent.asObservable() }
    var jsonTransformer: CodableTransformer
    private var networkRouter: MoyaProvider<UserTodoNetworkRouter>
    private var loadingEvent: PublishSubject<Bool>
    private var errorEvent: PublishSubject<String>
    private var response: Variable<UserTodoListResponse?>
    private var disposeBag: DisposeBag
    private var userId: Int
    
    init(userId: Int) {
        self.userId = userId
        response = Variable(nil)
        loadingEvent = PublishSubject()
        errorEvent = PublishSubject()
        networkRouter =  MoyaProvider<UserTodoNetworkRouter>(plugins: [NetworkLoggerPlugin()])
        jsonTransformer = CodableTransformer()
        disposeBag = DisposeBag()
    }
    
    
    func getTodoList() {
        let request = UserTodoListRequest(userId: "\(userId)")
        loadingEvent.onNext(true)
        networkRouter
            .rx
            .request(.UserTodoList(request: request))
            .map(mapMoyaResponse(from:))
            .asObservable()
            .do(onNext: { [weak self] _ in self?.loadingEvent.onNext(false)},onError: handleOperationError(with:))
            .bind(to: response)
            .disposed(by: disposeBag)
    }
    
    private func mapMoyaResponse(from response: Response)throws ->UserTodoListResponse{
        guard let responseModel = jsonTransformer.decodeObject(from: response.data, to: UserTodoListResponse.self) else{ throw UserTodoListError.ServerError }
        return responseModel
        
    }
    
    private func handleOperationError(with error: Error){
        guard let operationError = error as? UserTodoListError else{
            errorEvent.onNext(UserTodoListError.ServerError.localizedDescription)
            return
        }
        errorEvent.onNext(operationError.localizedDescription)
    }
    
    private func createTodosObservable()->Observable<[UserTodoCellViewModel]>{
        return response
        .asObservable()
        .filterNil()
            .map{ $0.map{ UserTodoCellViewModel(title: $0.title, body: $0.body) } }
    }
    
}
