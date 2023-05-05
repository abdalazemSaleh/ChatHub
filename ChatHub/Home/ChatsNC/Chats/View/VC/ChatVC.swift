//
//  ChatVC.swift
//  ChatHub
//
//  Created by Abdalazem Saleh on 2023-04-30.
//

import UIKit

enum Section {
    case main
}

struct ChatModel: Hashable {
    let name: String
}

class ChatVC: UIViewController {
    
    // MARK: - Variables
    private let constant = Constant()
    private let ViewModel = ChatViewModel()
        
    private var dataSource: UITableViewDiffableDataSource<Section, ChatModel>!
    
    // MARK: - IBOUtlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewChatButtonItem()
        configureSearchController()
        configureTableView()
        updateData(ViewModel.getChats())
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureViewController()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureSearchController() {
        let searchController                                    = UISearchController()
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.placeholder                  = "Search for Chat"
        searchController.obscuresBackgroundDuringPresentation   = false
        navigationItem.searchController                         = searchController
    }
    
    // MARK: - Functions

    private func configureTableView() {
        let nibName = constant.chatCellNibName
        tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
        
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, model in
            let cell = tableView.dequeueReusableCell(withIdentifier: nibName, for: indexPath) as! ChatsCell
            cell.set(model)
            return cell
        })
        
        tableView.delegate = self
    }
    
    func updateData(_ on: [ChatModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ChatModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(on)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension ChatVC: UITableViewDelegate, UISearchResultsUpdating {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text else { return }
        let fillterdData = ViewModel.searchForChat(filter)
        updateData(fillterdData)
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(ViewModel.getChats())
    }
}
