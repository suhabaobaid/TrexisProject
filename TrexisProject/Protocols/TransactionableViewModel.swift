//
//  TransactionableViewModel.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/4/22.
//

import Foundation

protocol TransactionAbledViewModel: AnyObject {
    func getTransactions(forAccountID accountID: String, completion: @escaping ([Transaction]) -> Void)
}
