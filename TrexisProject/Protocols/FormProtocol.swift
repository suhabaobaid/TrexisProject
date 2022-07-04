//
//  FormProtocol.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/3/22.
//

import UIKit

protocol FormValidable {
    var isValid: Bool {get set}
    var isMandatory: Bool {get set}
    func checkValidity()
}

/// Conform the view receiver to be updated with a form item
protocol FormUpdatable {
    func update(with formItem: FormItem)
}

/// Conform receiver to have a form item property
protocol FormConformity {
    var formItem: FormItem? {get set}
}

protocol Form {
    var title: String { get set }
    var username: String? { get set }
    var password: String? { get set }
    var authenticateButtonTitle: String { get set }
    var formItems: [FormItem] { get set }
    func isValid() -> (Bool, String?)
}
