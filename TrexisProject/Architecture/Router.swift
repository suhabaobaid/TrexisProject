//
//  Router.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/3/22.
//

import UIKit

class Router: NSObject, Presentable, UINavigationControllerDelegate {
    private var completions: [UIViewController: () -> Void]
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        self.completions = [:]
        super.init()
        self.navigationController.delegate = self
        self.navigationController.navigationBar.tintColor = .white
    }
    
    // MARK: - Presentable
    func toPresentable() -> UIViewController {
        return navigationController
    }
    
    deinit {
        if let presented = navigationController.presentedViewController {
            dismiss(presented)
        }
    }
    
    func present(_ presentable: Presentable, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.present(presentable.toPresentable(), animated: animated, completion: completion)
    }
    
    func dismiss(_ presentable: Presentable, animated: Bool = true, completion: (() -> Void)? = nil) {
        if navigationController.presentedViewController == presentable.toPresentable() {
            navigationController.dismiss(animated: animated, completion: completion)
        }
    }
    
    func dismiss(coordinator: Coordinator, animated: Bool = true, completion: (() -> Void)? = nil) {
        dismiss(coordinator.toPresentable())
    }
    
    func push(_ presentable: Presentable, animated: Bool = true, completion: (() -> Void)? = nil) {
        let controller = presentable.toPresentable()
        
        guard controller is UINavigationController == false else { return }
        
        if let completion = completion {
            completions[controller] = completion
        }
        
        navigationController.pushViewController(controller, animated: animated)
    }
    
    func pop(animated: Bool = true) {
        if let controller = navigationController.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }
    
    func setRoot(_ presentable: Presentable, hideBar: Bool = false, animated: Bool = false, completion: (() -> Void)? = nil) {
        // call all completions so all coordinators are deallocated
        for controller in navigationController.viewControllers {
            runCompletion(for: controller)
        }
        
        let controller = presentable.toPresentable()
        
        if let vc = controller as? UINavigationController {
            navigationController.setViewControllers(vc.viewControllers, animated: animated)
            if let completion = completion {
                vc.viewControllers.forEach { completions[$0] = completion }
            }
        } else {
            navigationController.setViewControllers([controller], animated: animated)
            
            if let completion = completion {
                completions[controller] = completion
            }
        }
        
        navigationController.isNavigationBarHidden = hideBar
    }
    
    func popToRoot(animated: Bool) {
        if let controllers = navigationController.popToRootViewController(animated: animated) {
            controllers.forEach { runCompletion(for: $0) }
        }
    }
    
    func popTo(_ presentable: Presentable, animated: Bool = true) {
        if let controllers = navigationController.popToViewController(presentable.toPresentable(), animated: animated) {
            controllers.forEach { runCompletion(for: $0) }
        }
    }
    
    private func runCompletion(for viewController: UIViewController) {
        guard let completion = completions[viewController] else { return }
        completion()
        completions.removeValue(forKey: viewController)
    }
    
    // MARK: - UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // NOTE: This is to make sure that the navigation we are doing is from the back button
        guard let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(poppedViewController) else {
            return
        }
        
        runCompletion(for: poppedViewController)
    }
    
}
