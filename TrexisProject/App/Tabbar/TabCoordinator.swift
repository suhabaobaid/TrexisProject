//
//  TabCoordinator.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/3/22.
//

import UIKit

class TabCoordinator: Coordinator {
    
    // MARK: - Child Coordinators
    private lazy var dashboardCoordinator: DashboardCoordinator = {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(title: "Dashboard", image: UIImage(systemName: "list.bullet.circle"), selectedImage: UIImage(systemName: "list.bullet.circle.fill"))
        let router = Router(navigationController: navigationController)
        let coordinator = DashboardCoordinator(router: router, navigationType: .newFlow(hideBar: false))
        addChild(coordinator)
        
        return coordinator
    }()
    
    private lazy var favoriteCoordinator: FavoriteCoordinator = {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "star.circle"), selectedImage: UIImage(systemName: "star.circle.fill"))
        let router = Router(navigationController: navigationController)
        let coordinator  = FavoriteCoordinator(router: router, navigationType: .newFlow(hideBar: false))
        addChild(coordinator)
        
        return coordinator
    }()
    
    private lazy var profileCoordinator: ProfileCoordinator = {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName: "person.crop.circle"))
        let router = Router(navigationController: navigationController)
        let coordinator  = ProfileCoordinator(router: router, navigationType: .newFlow(hideBar: false))
        addChild(coordinator)
        
        return coordinator
    }()
    
    private var rootVC: UITabBarController
    
    override var root: Presentable {
        return rootVC
    }
    
    init(tabbarController: UITabBarController, router: Router, navigationType: NavigationType) {
        self.rootVC = tabbarController
        
        super.init(router: router, navigationType: navigationType)
        
        self.configureTabs()
    }
    
    deinit {
        print("Deinit: Tabbar")
    }
    
    private func configureTabs() {
        
        rootVC.setViewControllers([dashboardCoordinator.toPresentable(), profileCoordinator.toPresentable(), favoriteCoordinator.toPresentable()], animated: true)
        rootVC.tabBar.isTranslucent = true
        rootVC.delegate = self
    }
}

extension TabCoordinator: UITabBarControllerDelegate {
    
}
