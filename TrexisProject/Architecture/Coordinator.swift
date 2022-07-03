//
//  Coordinator.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/3/22.
//

import UIKit
import Combine

class Coordinator: NSObject {
    enum NavigationType {
        case currentFlow // push (using the same stack)
        case newFlow(hideBar: Bool) // present, set root (creating a new stack of navigation)
    }
    
    let router: Router
    
    private var childCoordinators: [Coordinator] = []
    private let navigationType: NavigationType
    
    var disposeBag = Set<AnyCancellable>()
    
    // For Deeplink purposes to be used in coordinators to define the path to go through
    let deeplinkSubject = CurrentValueSubject<String?, Never>(nil)
    var deeplinkDisposeBag = Set<AnyCancellable>()
    
    var root: Presentable {
        fatalError("Override")
    }
    
    init(router: Router, navigationType: NavigationType) {
        self.router = router
        self.navigationType = navigationType
        
        super.init()
        
        if case .newFlow(let hidebar) = navigationType {
            router.setRoot(root, hideBar: hidebar, animated: true)
        }
    }
    
    func resetDeeplink() {
        for child in childCoordinators {
            child.deeplinkDisposeBag = Set<AnyCancellable>()
        }
        deeplinkSubject.send(nil)
    }
    
    func addChild(_ coordinator: Coordinator) {
        deeplinkSubject
            .subscribe(coordinator.deeplinkSubject)
            .store(in: &coordinator.deeplinkDisposeBag)
        
        childCoordinators.append(coordinator)
    }
    
    func removeChild(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(of: coordinator) {
            childCoordinators.remove(at: index)
        }
    }
    
    func setRootChild(coordinator: Coordinator, hideBar: Bool, animated: Bool = false) {
        addChild(coordinator)
        router.setRoot(coordinator, hideBar: hideBar, animated: animated) { [weak self, weak coordinator] in
            guard let coord = coordinator else { return }
            self?.removeChild(coord)
        }
    }
    
    func pushChild(coordinator: Coordinator, animated: Bool, onRemove: (() -> Void)? = nil) {
        addChild(coordinator)
        
        router.push(coordinator, animated: animated) { [weak self, weak coordinator] in
            guard let self = self, let coord = coordinator else { return }
            onRemove?()
            self.removeChild(coord)
        }
    }
    
    // Make sure to always call dismissChild after
    func presentChild(coordinator: Coordinator, animated: Bool) {
        addChild(coordinator)
        router.present(coordinator, animated: animated)
    }
    
    func dismissChild(_ coordinator: Coordinator, animated: Bool) {
        coordinator.toPresentable().presentingViewController?.dismiss(animated: animated, completion: nil)
        removeChild(coordinator)
    }
    
}

// MARK: - Presentable
extension Coordinator: Presentable {
    func toPresentable() -> UIViewController {
        switch navigationType {
            case .currentFlow:
                return root.toPresentable()
            case .newFlow:
                return router.toPresentable()
        }
    }
}

