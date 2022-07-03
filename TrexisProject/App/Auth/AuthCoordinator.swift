//
//  AuthCoordinator.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/3/22.
//

import Foundation

class AuthCoordinator: Coordinator {
    
    private var rootVC: Presentable
    
    override var root: Presentable {
        return rootVC
    }
    
    init(rootVC: Presentable, router: Router, navigationType: Coordinator.NavigationType) {
        self.rootVC = rootVC
        super.init(router: router, navigationType: navigationType)
    }
    
}
