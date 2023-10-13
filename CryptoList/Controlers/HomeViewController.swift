//
//  ViewController.swift
//  CryptoList
//
//  Created by Alexandr Alimov on 05/10/23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    //MARK: - UI Components
    private let viewModel: HomeControllerViewModel
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    
    //MARK: - LifeCycle
    init(_ viewModel: HomeControllerViewModel = HomeControllerViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setHierarchy()
        setLayouts()
        
        setSerchController()
        setCoins()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

//MARK: - HomeViewController Extensions
extension HomeViewController {
    //MARK: - Set Views
    private func setViews() {
        title = "Crypto currency"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        self.view.backgroundColor = .systemBackground
        
        tableView.backgroundColor = .systemBackground
        tableView.register(CoinCell.self, forCellReuseIdentifier: CoinCell.identifie)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    //MARK: - Set Hierarchy
    private func setHierarchy() {
        self.view.addSubview(tableView)
    }
    
    //MARK: - Set constraints
    private func setLayouts() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

//MARK: - TableView functions
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let inSearchMode = self.viewModel.ifSearchMode(searchController)
        
        return inSearchMode ? self.viewModel.filteredCoins.count : self.viewModel.allCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.identifie,
                                                       for: indexPath) as? CoinCell else {
            fatalError("Unable to dequeue CoinCell")
        }
        let inSearchMode = self.viewModel.ifSearchMode(searchController)
        let coin = inSearchMode ? self.viewModel.filteredCoins[indexPath.row] : self.viewModel.allCoins[indexPath.row]
        // let coin = self.viewModel.allCoins[indexPath.row]
        cell.configCell(with: coin)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let inSearchMode = self.viewModel.ifSearchMode(searchController)
        let coin = inSearchMode ? self.viewModel.filteredCoins[indexPath.row] : self.viewModel.allCoins[indexPath.row]
        // let coin = self.viewModel.allCoins[indexPath.row]
        let vm = DetailCryptoControllerViewModel(coin)
        let vc = DetailCryptoViewController(vm)
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Set Cell Data
extension HomeViewController {
    func setCoins() {
        //MARK: - Cell Update
        self.viewModel.onCoinsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        //MARK: - Handle Error Message
        self.viewModel.onErrorMessage = { [weak self] error in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                switch error {
                case .serverError(let serverError):
                    alert.title = "Server error \(serverError.errorCode)"
                    alert.message = serverError.errorMessage
                case .unknownError(let string):
                    alert.title = "Error Fetching Coins"
                    alert.message = string
                case .decodingError(let string):
                    alert.title = "Error Parsing Data"
                    alert.message = string
                }
                
                self?.present(alert, animated: true, completion: nil)
            }
        }
        
    }
}

//MARK: - Setup Search Bar
extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.viewModel.updateSearchController(searchBarText: searchController.searchBar.text)
    }
    
    private func setSerchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Crypto"
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}

