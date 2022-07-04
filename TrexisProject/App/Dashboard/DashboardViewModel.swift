//
//  DashboardViewModel.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/4/22.
//

import UIKit

final class DashboardViewModel: NSObject, TransactionAbledViewModel {
    
    // MARK: - Properties
    var alert: Box<Alert?> = Box(nil)
    
    // MARK: - Dependencies
    var apiService: APIService
    
    // MARK: - init
    init(apiService: APIService) {
        self.apiService = apiService
        super.init()
    }
    
    // MARK: - API calls
    func getAccounts(completion: @escaping ([Account]) -> Void) {
        apiService.getAccounts { [weak self] data, status, error in
            if status == 200 {
                let decoder = JSONDecoder()
                do {
                    let accounts = try decoder.decode([Account].self, from: data as! Data)
                    completion(accounts)
                } catch {
                    print(error.localizedDescription)
                    completion([])
                }
            } else {
                self?.alert.value = Alert(isError: true, message: "Server error - Unable to get accounts")
                completion([])
            }
            
        }
    }
    
    func getTransactions(forAccountID accountID: String, completion: @escaping ([Transaction]) -> Void) {
        apiService.fetchTransactions(for: accountID) { [weak self] data, status, error in
            if status == 200 {
                let decoder = JSONDecoder()
                do {
                    let transactions = try decoder.decode([Transaction].self, from: data as! Data)
                    completion(transactions)
                } catch {
                    print(error.localizedDescription)
                    self?.alert.value = Alert(isError: true, message: error.localizedDescription)
                    completion([])
                }
            } else {
                self?.alert.value = Alert(isError: true, message: "Server error")
                completion([])
            }
        }
    }
}
