//
//  TabCoordinator.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/3/22.
//

import UIKit

class TabCoordinator: Coordinator {
    
    private var rootVC: UITabBarController
    
    var dashboardCoordinator: DashboardCoordinator
    var favoriteCoordinator: FavoriteCoordinator
    var profileCoordinator: ProfileCoordinator
    
    override var root: Presentable {
        return rootVC
    }
    
    init(tabbarController: UITabBarController, router: Router, navigationType: NavigationType) {
        self.rootVC = tabbarController
        
        dashboardCoordinator = DashboardCoordinator(router: Router(), navigationType: .newFlow(hideBar: true))
        favoriteCoordinator = FavoriteCoordinator(router: Router(), navigationType: .newFlow(hideBar: true))
        profileCoordinator = ProfileCoordinator(router: Router(), navigationType: .newFlow(hideBar: true))
        
        super.init(router: router, navigationType: navigationType)
        
        self.configureTabs()
    }
    
    private func configureTabs() {
        
        addChild(dashboardCoordinator)
        addChild(favoriteCoordinator)
        addChild(profileCoordinator)
        
        rootVC.setViewControllers([dashboardCoordinator.toPresentable(), profileCoordinator.toPresentable(), favoriteCoordinator.toPresentable()], animated: true)
        rootVC.tabBar.isTranslucent = true
        rootVC.delegate = self
    }
}

extension TabCoordinator: UITabBarControllerDelegate {
    
}
