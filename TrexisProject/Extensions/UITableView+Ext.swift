//
//  UITableView+Ext.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/3/22.
//

import UIKit

extension UITableView {
    func register(cell: UITableViewCell.Type) {
        let className = String(describing: cell)
        self.register(cell, forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T>(_ type: T.Type) -> T? {
        let className = String(describing: type)
        return dequeueReusableCell(withIdentifier: className) as? T
    }
}
