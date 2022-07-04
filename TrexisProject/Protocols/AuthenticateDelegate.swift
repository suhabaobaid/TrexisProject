//
//  AuthenticateDelegate.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/3/22.
//

import Foundation

protocol AuthenticateDelegate: AnyObject {
    func authenticateUser()
}

protocol AuthCoordinatorDelegate: AnyObject {
    func didFinishAuth()
}
