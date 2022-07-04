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
    
    deinit {
        print("Deinit: ProfileCoordinator")
    }
    
    private func configure() {
        rootVC.title = "Profile"
        
    }
}
