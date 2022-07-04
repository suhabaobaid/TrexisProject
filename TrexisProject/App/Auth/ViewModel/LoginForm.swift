//
//  loginForm.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/3/22.
//

import Foundation

class LoginForm: Form {
    var formItems = [FormItem]()
    
    var title: String
    var authenticateButtonTitle: String
    
    var username: String?
    var password: String?
    
    init(title: String, buttonTitle: String) {
        self.title = title
        self.authenticateButtonTitle = buttonTitle
        self.configureItems()
    }
    
    // MARK: Form Validation
    @discardableResult
    func isValid() -> (Bool, String?) {
        
        var isValid = true
        for item in self.formItems {
            item.checkValidity()
            if !item.isValid {
                isValid = false
            }
        }
        return (isValid, nil)
    }
    
    /// Prepare all form Items ViewModels for the DirectStudioForm
    private func configureItems() {
        
        // Username
        let usernameItem = FormItem(placeholder: "Enter your username")
        usernameItem.uiProperties.cellType = FormItemCellType.textField
        usernameItem.value = self.username
        usernameItem.valueCompletion = { [weak self, weak usernameItem] value in
            self?.username = value
            usernameItem?.value = value
        }
        
        // password
        let passwordItem = FormItem(placeholder: "Password")
        passwordItem.uiProperties.cellType = FormItemCellType.textField
        passwordItem.uiProperties.keyboardType = .default
        passwordItem.uiProperties.isSecureText = true
        passwordItem.value = self.password
        passwordItem.valueCompletion = { [weak self, weak passwordItem] value in
            self?.password = value
            passwordItem?.value = value
        }
        
        self.formItems = [usernameItem, passwordItem]
    }
}
