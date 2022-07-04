//
//  AuthCoordinator.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/3/22.
//

import Foundation

class AuthCoordinator: Coordinator {
    
    private var rootVC: LoginViewController
    private var viewModel: AuthViewModel
    
    weak var delegate: AuthCoordinatorDelegate?
    
    override var root: Presentable {
        return rootVC
    }
    
    override init(router: Router, navigationType: Coordinator.NavigationType) {
        self.viewModel = AuthViewModel(apiService: APIService())
        self.rootVC = LoginViewController(form: viewModel.getForm(for: .login))
        
        
        super.init(router: router, navigationType: navigationType)
        
        rootVC.delegate = self
        self.router.navigationController.navigationBar.prefersLargeTitles = true
    }
    
}

extension AuthCoordinator: AuthenticateDelegate {
    func authenticateUser() {
        let loadingIndicator = LoadingViewController()
        rootVC.toPresentable().add(loadingIndicator)
        
        viewModel.logInUser { [weak self, weak loadingIndicator] didLogIn, errorMessage in
            loadingIndicator?.remove()
            if didLogIn {
                self?.delegate?.didFinishAuth()
            } else {
                self?.rootVC.presentMinimumAlertonMainThread(message: "Unable to authenticate", isError: true, dismissTime: 3)
            }
        }
    }
}
