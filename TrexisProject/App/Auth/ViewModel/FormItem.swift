//
//  FormItem.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/3/22.
//

import UIKit

/// UIKit properties for ViewModels
struct FormItemUIProperties {
    var tintColor = UIColor.red
    var keyboardType = UIKeyboardType.default
    var isSecureText: Bool = false
    var cellType: FormItemCellType?
    var returnKeyType: UIReturnKeyType = .default
}


class FormItem: FormValidable {
    
    var value: String?
    var placeholder = ""
    var indexPath: IndexPath?
    var valueCompletion: ((String?) -> Void)?
    
    var isMandatory = true
    
    var isValid = true //FormValidable
    
    var uiProperties = FormItemUIProperties()
    
    // MARK: Init
    init(placeholder: String, value: String? = nil) {
        self.placeholder = placeholder
        self.value = value
    }
    
    // MARK: FormValidable
    func checkValidity() {
        if self.isMandatory {
            self.isValid = self.value != nil && self.value?.isEmpty == false
        } else {
            self.isValid = true
        }
    }
}

/// UI Cell Type to be displayed
enum FormItemCellType {
    case textField
    
    /// Registering methods for all forms items cell types
    ///
    /// - Parameter tableView: TableView where apply cells registration
    static func registerCells(for tableView: UITableView) {
        tableView.register(cell: FormTextFieldTableViewCell.self)
    }
    
    /// Correctly dequeue the UITableViewCell according to the current cell type
    ///
    /// - Parameters:
    ///   - tableView: TableView where cells previously registered
    ///   - indexPath: indexPath where dequeue
    /// - Returns: a non-nullable UITableViewCell dequeued
    func dequeueCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        
        switch self {
            case .textField:
                cell = tableView.dequeueReusableCell(FormTextFieldTableViewCell.self)!
                
        }
        
        return cell
    }
}
