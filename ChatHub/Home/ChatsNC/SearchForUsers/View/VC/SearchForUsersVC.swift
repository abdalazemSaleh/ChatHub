//
//  SearchForUsersVC.swift
//  ChatHub
//
//  Created by Abdalazem Saleh on 2023-05-03.
//

import UIKit

class SearchForUsersVC: UIViewController {

    // MARK: - Variales
    let constant = Constant()
    let viewModel = SearchForUsersViewModel()
    var activityIndicator = UIActivityIndicatorView()

    private var dataSource: UITableViewDiffableDataSource<Section, UserModel>!
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTbaleView()
        configureSearchController()
        getUsersFromViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureViewController()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureViewController() {
        title = "Users"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureSearchController() {
        let searchController                                    = UISearchController()
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.placeholder                  = "Search for User"
        searchController.obscuresBackgroundDuringPresentation   = false
        navigationItem.searchController                         = searchController
    }
    
    // MARK: - Functions
    private func configureTbaleView() {
        let nibName = constant.userCellNib
        tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
        
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, user in
            let cell = tableView.dequeueReusableCell(withIdentifier: nibName, for: indexPath) as! UserCell
            cell.set(user: user)
            return cell
        })
        
        tableView.delegate = self
    }
    
    func updateData(_ on: [UserModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, UserModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(on)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    // MARK: - UIFunctions
    private func getUsersFromViewModel() {
        configureActiveIndicator()
        viewModel.fetchUsers { [weak self] users in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            self.updateData(users)
        }
    }
    
    private func configureActiveIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.startAnimating()
    }
}

extension SearchForUsersVC: UITableViewDelegate, UISearchResultsUpdating {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text else { return }
        let fillterdData = viewModel.searchForUser(filter)
        updateData(fillterdData)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(viewModel.getUsers())
    }
}
