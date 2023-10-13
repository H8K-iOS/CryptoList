//
//  DetailCryptoControllerViewModel.swift
//  CryptoList
//
//  Created by Alexandr Alimov on 06/10/23.
//

import UIKit

final class DetailCryptoControllerViewModel {
    //MARK: - callback
    //    we dont need it with SDWebImg
    //    var onImageLoaded: ((UIImage?) -> Void)?
    
    //MARK: - Variables
    let coin: Coin
    
    //MARK: - Initializer
    init(_ coin: Coin) {
        self.coin = coin
        //        self.loadImage()
    }
    
    //    we need it with SDWebImg
    //    private func loadImage() {
    //        DispatchQueue.global().async { [weak self] in
    //            if let logoURL = self?.coin.logoURL,
    //               let imageData = try? Data(contentsOf: logoURL),
    //               let logoImage = UIImage(data: imageData) {
    //                self?.onImageLoaded?(logoImage)
    //            }
    //        }
    //
    //    }
    
    //MARK: - Computed Properties
    var rankLabel: String {
        "Rank: \(self.coin.rank)"
    }
    
    var priceLabel: String {
        "Price: $ \(self.coin.pricingData.USD.price) USD"
    }
    
    var marketCapLabel: String {
        "Market Cap: $ \(self.coin.pricingData.USD.market_cap) USD"
    }
    
    var maxSupplyLabel: String {
        
        if let maxSupply = self.coin.maxSupply  {
            return "Max supply: \(maxSupply)"
        } else {
            return "123\n123\n312\n123\n312\n123\n312\n123\n312\n123\n312\n123\n312\n123\n312\n123\n312\n123\n312\n123\n312\n123\n312\n123\n312\n123\n312\n123\n312\n123\n312\n123\n312\n123\n312\n123\n312\n123\n312\n123\n312\n123\n312"
        }
    }
}
