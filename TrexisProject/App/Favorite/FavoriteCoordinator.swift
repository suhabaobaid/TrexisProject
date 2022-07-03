//
//  FavoriteCoordinator.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/3/22.
//

import Foundation
import UIKit

class FavoriteCoordinator: Coordinator {
    override var root: Presentable {
        return router.toPresentable()
    }
    
    override init(router: Router, navigationType: Coordinator.NavigationType) {
        super.init(router: router, navigationType: navigationType)
        configure()
    }
    
    private func configure() {
        router.navigationController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "star.circle"), selectedImage: UIImage(systemName: "star.circle.fill"))
    }
}
