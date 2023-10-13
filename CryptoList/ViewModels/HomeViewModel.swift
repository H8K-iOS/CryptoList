//
//  HomeViewModels.swift
//  CryptoList
//
//  Created by Alexandr Alimov on 05/10/23.
//

import UIKit

final class HomeControllerViewModel {
    
    var onCoinsUpdated: (()->Void)?
    var onErrorMessage: ((CoinServiceError)->Void)?
    private(set) var filteredCoins: [Coin] = []
    private(set) var allCoins: [Coin] = [] {
        didSet {
            self.onCoinsUpdated?()
        }
    }
    
    //MARK: - Life Cycle
    init() {
        self.fetchCoins()
    }
    
    //MARK: - Functions
    public func fetchCoins() {
        let endpoint = Endpoint.fetchCoins()
        CoinService.fetchCoins(with: endpoint) { [weak self] result in
            switch result {
            case .success(let coins):
                self?.allCoins = coins
                print("DEBUG PRINT:", "\(coins.count) coins fetched")
                
            case .failure(let err):
                self?.onErrorMessage?(err)
            }
        }
    }
}

//MARK: - Search Functions
extension HomeControllerViewModel {
    
    public func ifSearchMode(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        
        return isActive && !searchText.isEmpty
    }
    
    public func updateSearchController(searchBarText: String?) {
        self.filteredCoins = allCoins
        
        if let searchText = searchBarText?.lowercased() {
            guard !searchText.isEmpty else { self.onCoinsUpdated?(); return }
            self.filteredCoins = self.filteredCoins.filter({ $0.name.lowercased().contains(searchText)})
        }
        
        self.onCoinsUpdated?()
    }
    
}
