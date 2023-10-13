import UIKit

final class DetailCryptoControllerViewModel {
    //MARK: - Variables
    let coin: Coin
    
    //MARK: - Initializer
    init(_ coin: Coin) {
        self.coin = coin
    }
    
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
            return "Max supply: unknown supply"
        }
    }
}
