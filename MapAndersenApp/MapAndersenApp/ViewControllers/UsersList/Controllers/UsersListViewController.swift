//
//  ViewController.swift
//  MapAndersenApp
//
//  Created by Вячеслав Савицкий on 24.01.2020.
//  Copyright © 2020 Вячеслав Савицкий. All rights reserved.
//

import UIKit

protocol UsersListViewProtocol: class {
    func errorAlert(title: String)
    func reloadData()
}

class UsersListViewController: UIViewController, UsersListViewProtocol {
    //MARK: - Private outlet
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - Private properties
    private var presenter: UsersListPresenterProtocol?
    private let paginationRowNumber = 3
    
    let refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshing(sender:)), for: .valueChanged)
        return refresh
    }()
    
    //MARK: - LifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = UsersListPresenter()
        presenter?.view = self
        configTableViewCell()
        presenter?.viewDidLoad()
    }
    
    //MARK: - Private func
    @objc private func refreshing(sender: UIRefreshControl) {
        presenter?.refreshUsers()
        sender.endRefreshing()
    }
    
    private func configTableViewCell() {
        tableView.register(UINib(nibName: String(describing: UserCell.self), bundle: nil), forCellReuseIdentifier: String(describing: UserCell.self))
        tableView.refreshControl = refreshControl
    }
    
    //MARK: - Private action
    @IBAction private func didTapGoToMap(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: MapViewController.self)) as! MapViewController
        guard let presenter = presenter else { return }
        vc.users = presenter.users()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Protocol func
    func errorAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
        }))
        present(alert, animated: true, completion: nil)
    }

    func reloadData() {
        tableView.reloadData()
    }
}

//MARK: - Delegate funcs
extension UsersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.countRows() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter else { return UITableViewCell() }
        let cellModel = presenter.model(index: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: cellModel.cellType), for: indexPath) as! BaseCell
        cell.update(entity: cellModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let count = presenter?.countRows() else { return }
        if indexPath.row == count - paginationRowNumber {
            presenter?.getDataForPagination()
        }
    }
}
