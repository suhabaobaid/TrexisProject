//
//  AuthViewModel.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/3/22.
//

import Foundation

enum AuthFormType {
    case login
    case signup
}

final class AuthViewModel: NSObject {
    
    // MARK: - Properties
    var form: Form?
    
    // MARK: - Dependencies
    private var apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
        super.init()
    }
    
    // MARK: - Functions
    func getForm(for type: AuthFormType) -> Form {
        switch type {
            case .login:
                self.form = LoginForm(title: "Log in", buttonTitle: "Log in")
            case .signup:
                self.form = LoginForm(title: "Sign up", buttonTitle: "Create Account")
        }
        
        return self.form!
    }
    
    // MARK: - API Calls
    func logInUser(completionHandler: @escaping (Bool, String?) -> Void) {
        guard let form = form , let username = form.username, let password = form.password else {
            return
        }
        apiService.login(withUsername: username, password: password) { json, status, error in
            completionHandler(status == 200, error?.localizedDescription)
        }
    }
    
}
