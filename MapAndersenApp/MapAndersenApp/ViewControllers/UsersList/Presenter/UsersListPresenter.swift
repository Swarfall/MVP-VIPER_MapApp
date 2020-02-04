//
//  UsersListPresenter.swift
//  MapAndersenApp
//
//  Created by Вячеслав Савицкий on 24.01.2020.
//  Copyright © 2020 Вячеслав Савицкий. All rights reserved.
//

import Foundation
import UIKit

protocol UsersListPresenterProtocol {
    var view: UsersListViewProtocol? { get set }
    func countRows() -> Int
    func model(index: Int) -> TableCellBaseViewModel
    func viewDidLoad()
    func getDataForPagination()
    func users() -> [UserViewModel]
    func refreshUsers() 
}

class UsersListPresenter {
    //MARK: - Protocol property
    weak var view: UsersListViewProtocol?
    
    //MARK: - Private property
    private let requestManager = RequestManager()
    private let requestParameters = RequestParameters()
    private var userEntities = [UserViewModel]()
    
    //MARK: - Private funcs
    private func getUsers(page: Int) {
        requestManager.getUsersList(page: page, countObjects: requestParameters.results, success: { [weak self] (userResult) in
            guard let self = self else { return }
            for userData in userResult.results {
                let newUser = UserViewModel(model: userData)
                self.userEntities.append(newUser)
            }
            DispatchQueue.main.async {
                self.view?.reloadData()
            }
        }, fail: { [weak self] (error) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.view?.errorAlert(title: error)
            }
        })
    }
}

extension UsersListPresenter: UsersListPresenterProtocol {
    //MARK: - Protocol funcs
    func refreshUsers() {
        requestParameters.page = 1
        userEntities.removeAll()
        getUsers(page: requestParameters.page)
    }
    
    func users() -> [UserViewModel] {
        return userEntities
    }

    func countRows() -> Int {
        return userEntities.count
    }
    
    func model(index: Int) -> TableCellBaseViewModel {
        return userEntities[index]
    }
    
    func viewDidLoad() {
        requestParameters.page = 1
        getUsers(page: requestParameters.page)
    }
    
    func getDataForPagination() {
        requestParameters.page += 1
        getUsers(page: requestParameters.page)
    }
}
