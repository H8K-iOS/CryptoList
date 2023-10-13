import UIKit

final class DetailCryptoViewController: UIViewController {
    let viewModel: DetailCryptoControllerViewModel
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let coinLogo = UIImageView()
    private let coinRankLabel = UILabel()
    private let coinPriceLabel = UILabel()
    private let coinCapLabel = UILabel()
    private let coinMaxSupplyLabel = UILabel()
    
    private lazy var vStackView: UIStackView = {
        let vStac = UIStackView(arrangedSubviews: [coinRankLabel, coinPriceLabel, coinCapLabel, coinMaxSupplyLabel])
        vStac.axis = .vertical
        vStac.spacing = 12
        vStac.distribution = .fill
        vStac.alignment = .center
        return vStac
    }()
    
    //MARK: - Lifecycle
    init(_ viewModel: DetailCryptoControllerViewModel) {
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
        displayCrypto()
    }
}


extension DetailCryptoViewController {
    private func displayCrypto() {
        self.coinRankLabel.text = viewModel.rankLabel
        self.coinPriceLabel.text = viewModel.priceLabel
        self.coinCapLabel.text = viewModel.marketCapLabel
        
        self.coinMaxSupplyLabel.text = self.viewModel.maxSupplyLabel
        self.coinLogo.sd_setImage(with: self.viewModel.coin.logoURL)
    }
    
    private func setViews() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = self.viewModel.coin.name
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: nil, action: nil)
        
        coinLogo.contentMode = .scaleAspectFit
        coinLogo.image = UIImage(systemName: "questionmark")
        coinLogo.tintColor = .label
        
        coinRankLabel.textColor = .label
        coinRankLabel.textAlignment = .center
        coinRankLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        coinRankLabel.text = "Error"
        
        coinPriceLabel.textColor = .label
        coinPriceLabel.textAlignment = .center
        coinPriceLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        coinPriceLabel.text = "Error"
        
        coinCapLabel.textColor = .label
        coinCapLabel.textAlignment = .center
        coinCapLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        coinCapLabel.text = "Error"
        
        coinMaxSupplyLabel.textColor = .label
        coinMaxSupplyLabel.textAlignment = .center
        coinMaxSupplyLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        coinMaxSupplyLabel.numberOfLines = 500
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        coinLogo.translatesAutoresizingMaskIntoConstraints = false
        vStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func setHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        self.contentView.addSubview(coinLogo)
        self.contentView.addSubview(vStackView)
        self.vStackView.addSubview(coinPriceLabel)
        self.vStackView.addSubview(coinCapLabel)
        self.vStackView.addSubview(coinMaxSupplyLabel)
    }
    
    
    //MARK: - Set constraints
    
    private func setLayouts() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            coinLogo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            coinLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            coinLogo.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            coinLogo.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            coinLogo.heightAnchor.constraint(equalToConstant: 200),

            vStackView.topAnchor.constraint(equalTo: coinLogo.bottomAnchor, constant: 18),
            vStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            vStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            vStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
