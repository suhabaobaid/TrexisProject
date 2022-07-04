//
//  AppCoordinator.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/3/22.
//

import UIKit

class AppCoordinator: Coordinator {
    
    override var root: Presentable {
        return router.toPresentable()
    }
    
    init(router: Router) {
        super.init(router: router, navigationType: .newFlow(hideBar: true))
        start()
    }
    
    func start() {
        if isLoggedIn() {
            showHomeScreen()
        } else {
            showLoginScreen()
        }
    }
    
    func showLoginScreen() {
        let authCoordinator = AuthCoordinator(router: router, navigationType: .newFlow(hideBar: false))
        authCoordinator.delegate = self
        setRootChild(coordinator: authCoordinator, hideBar: false)
    }
    
    func showHomeScreen() {
        let homeCoordinator = TabCoordinator(tabbarController: UITabBarController(), router: router, navigationType: .newFlow(hideBar: true))
        setRootChild(coordinator: homeCoordinator, hideBar: true)
    }
    
    private func isLoggedIn() -> Bool {
        guard let _ = UserDefaults.standard.string(forKey: "AccessToken") else {
            return false
        }
        return true
    }
    
}

// MARK: - AuthCoordinatorDelegate
extension AppCoordinator: AuthCoordinatorDelegate {
    func didFinishAuth() {
        showHomeScreen()
    }
}

