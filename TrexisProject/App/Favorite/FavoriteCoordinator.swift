//
//  FavoriteCoordinator.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/3/22.
//

import Foundation
import UIKit

class FavoriteCoordinator: Coordinator {
    
    var rootVC: FavoriteViewController
    
    override var root: Presentable {
        return rootVC
    }
    
    override init(router: Router, navigationType: Coordinator.NavigationType) {
        self.rootVC = FavoriteViewController()
        super.init(router: router, navigationType: navigationType)
        configure()
    }
    
    private func configure() {
        router.navigationController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "star.circle"), selectedImage: UIImage(systemName: "star.circle.fill"))
    }
}
