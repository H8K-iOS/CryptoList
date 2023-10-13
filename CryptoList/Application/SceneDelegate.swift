//
//  SceneDelegate.swift
//  CryptoList
//
//  Created by Alexandr Alimov on 05/10/23.
//

import UIKit
import SDWebImage

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: HomeViewController())
        window?.makeKeyAndVisible()
        
//        SDImageCache.shared.config.maxDiskSize = 1000000 * 200
    }
    
}
