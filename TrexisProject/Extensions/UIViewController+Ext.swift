//
//  UIViewController+Ext.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/3/22.
//

import UIKit

extension UIViewController: Presentable {
    
    public func toPresentable() -> UIViewController {
        return self
    }
    
    func addSubviews(_ views: [UIView]) {
        for childView in views {
            view.addSubview(childView)
        }
    }
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
}
