//
//  Box.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/4/22.
//

import Foundation

final class Box<T> {
    
    // MARK: - typealias
    typealias Listener = (T) -> Void
    
    // MARK: - Properties
    var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    // MARK: - init
    init(_ value: T) {
        self.value = value
    }
    
    // MARK: - functions
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    func remove() {
        listener = nil
    }
}
