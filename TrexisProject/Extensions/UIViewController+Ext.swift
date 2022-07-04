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
    
    func presentMinimumAlertonMainThread(message: String, isError: Bool, dismissTime: TimeInterval) {
        DispatchQueue.main.async {
            let image = isError ? UIImage(systemName: "checkmark.circle.trianglebadge.exclamationmark") : UIImage(systemName: "checkmark.circle")
            let color = isError ? Colors.errorColor : Colors.successColor
            let alertVC = MinimumAlertViewController(message: message, icon: image, color: color)
            alertVC.modalPresentationStyle = .overCurrentContext
            alertVC.modalTransitionStyle = .coverVertical
            self.present(alertVC, animated: true, completion: { [weak self, weak alertVC] in
                let dismissGesture = CustomTapGesture(target: self, action: #selector(self?.shouldDismiss(_:)))
                
                dismissGesture.alertVC = alertVC
                alertVC?.view.window?.isUserInteractionEnabled = true
                alertVC?.view.window?.addGestureRecognizer(dismissGesture)
                Timer.scheduledTimer(withTimeInterval: dismissTime, repeats: false) { _ in
                    self?.dismiss(animated: true, completion: nil)
                    alertVC?.view.window?.removeGestureRecognizer(dismissGesture)
                }
            })
        }
    }
    
    @objc func shouldDismiss(_ sender: UIGestureRecognizer) {
        if let sender = sender as? CustomTapGesture {
            sender.alertVC?.view.window?.removeGestureRecognizer(sender)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
