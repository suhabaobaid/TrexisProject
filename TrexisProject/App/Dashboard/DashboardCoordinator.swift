//
//  DashboardCoordinator.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/3/22.
//

import UIKit

class DashboardCoordinator: Coordinator {
    
    override var root: Presentable {
        return router.toPresentable()
    }
    
    override init(router: Router, navigationType: Coordinator.NavigationType) {
        super.init(router: router, navigationType: navigationType)
        configure()
    }
    
    private func configure() {
        router.navigationController.tabBarItem = UITabBarItem(title: "Dashboard", image: UIImage(systemName: "list.bullet.circle"), selectedImage: UIImage(systemName: "list.bullet.circle.fill"))
    }
}
