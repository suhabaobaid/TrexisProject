//
//  ProfileCoordinator.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/3/22.
//

import Foundation
import UIKit

class ProfileCoordinator: Coordinator {
    
    var rootVC: ProfileViewController
    
    override var root: Presentable {
        return rootVC
    }
    
    override init(router: Router, navigationType: Coordinator.NavigationType) {
        self.rootVC = ProfileViewController()
        super.init(router: router, navigationType: navigationType)
        configure()
    }
    
    private func configure() {
        router.navigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName: "person.crop.circle"))
    }
}
