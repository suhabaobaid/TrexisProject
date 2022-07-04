//
//  DashboardCoordinator.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/3/22.
//

import UIKit

protocol DashboardDelegate: AnyObject {
    func didTapOnAccount(_ account: Account)
}

class DashboardCoordinator: Coordinator {
    
    var rootVC: DashboardViewController
    var viewModel: DashboardViewModel
    
    override var root: Presentable {
        return rootVC
    }
    
    override init(router: Router, navigationType: Coordinator.NavigationType) {
        self.viewModel = DashboardViewModel(apiService: APIService())
        self.rootVC = DashboardViewController(title: "Dashboard", viewModel: viewModel)
        super.init(router: router, navigationType: navigationType)
        rootVC.delegate = self
        configure()
    }
    
    deinit {
        print("Deinit: DashboardCoordinator")
    }
    
    private func configure() {
        router.navigationController.navigationBar.tintColor = Colors.primaryColor
        router.navigationController.navigationBar.prefersLargeTitles = true
    }
    
    private func coordinateToTransactions(forAccount account: Account) {
        let transactionsVC = TransactionViewController(title: "Transactions", account: account, viewModel: viewModel)
        router.push(transactionsVC, animated: true)
    }
    
}

extension DashboardCoordinator: DashboardDelegate {
    func didTapOnAccount(_ account: Account) {
        coordinateToTransactions(forAccount: account)
    }
}
