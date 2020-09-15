//
//  TodoUserListViewController.swift
//  VIPER
//
//  Created by Mohamed El-Taweel on 9/1/20.
//  Copyright (c) 2020 Learning. All rights reserved.


import UIKit
import KRProgressHUD
import RxSwift
import RxCocoa


class TodoUserListViewController: UIViewController
{
    @IBOutlet weak var todoUserTableView: UITableView!
    
    private var viewModel: TodoUserListViewModelProtocol?
    private var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        viewModel = TodoUserListViewModel()
        setupRx()
        viewModel?.getUsersList()
        
    }
    
    private func setupRx(){
        guard let viewModel = viewModel else{ return }
        
        viewModel
            .users
            .bind(to: todoUserTableView.rx.items(cellIdentifier: TodoUserTableViewCell.IDENTIFIER, cellType: TodoUserTableViewCell.self)) {(row, element, cell) in
                cell.config(with: element)
        }
        .disposed(by: disposeBag)
        
        todoUserTableView
            .rx
            .itemSelected
            .asObservable()
            .map{ $0.row}
            .bind(to: viewModel.selectedUser)
            .disposed(by: disposeBag)
        
        viewModel
            .shouldShowErrorMessage
            .subscribe(onNext: { KRProgressHUD.showError(withMessage: $0) })
            .disposed(by: disposeBag)
        
        viewModel
            .shouldShowLoading
            .subscribe(onNext: handleLoadingIndicator(with:))
            .disposed(by: disposeBag)
        
        viewModel
            .shouldBrowseUserTodos
            .subscribe(onNext: showUserTodos(with:))
            .disposed(by: disposeBag)
            
    }
    
    private func showUserTodos(with userId: Int){
        let destinationViewController = UIViewController.create(storyboardName: "UserTodoList", viewControllerID: "UserTodoListViewController") as! UserTodoListViewController
        destinationViewController.userId = userId
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    private func handleLoadingIndicator(with flag: Bool){
        if flag{
            KRProgressHUD.show()
        }else{
            KRProgressHUD.dismiss()
        }
    }
    
}


