//
//  CoinCell.swift
//  CryptoList
//
//  Created by Alexandr Alimov on 05/10/23.
//

import UIKit
import SDWebImage

final class CoinCell: UITableViewCell {
    static let identifie = "CoinCell"
    
    // MARK: - Varriables
    private(set) var coin: Coin!
    
    
    // MARK: - UI Components
    private let coinLogo: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "questionmark")
        iv.tintColor = .black
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let coinName: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "Error"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configCell(with coin: Coin) {
        self.coin = coin
        self.coinName.text = coin.name
        self.coinLogo.sd_setImage(with: coin.logoURL)
        
        //without SDWebImg
        //        DispatchQueue.global().async { [weak self] in
        //            if let logoURL = coin.logoURL,
        //               let imageData = try? Data(contentsOf: logoURL),
        //               let logoImage = UIImage(data: imageData) {
        //                DispatchQueue.main.async {
        //                    self?.coinLogo.image = logoImage
        //                }
        //
        //            }
        //        }
    }
    
    //MARK: - Prepare for reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        self.coinLogo.image = nil
        self.coinName.text = nil
    }
    
    //MARK: - UI Setup
    
    private func setupUI() {
        self.addSubview(coinName)
        self.addSubview(coinLogo)
        
        NSLayoutConstraint.activate([
            coinLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            coinLogo.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor),
            coinLogo.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            coinLogo.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            
            coinName.leftAnchor.constraint(equalTo: coinLogo.rightAnchor, constant: 20),
            coinName.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}
