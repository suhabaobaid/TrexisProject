//
//  DashboardTests.swift
//  TrexisProjectTests
//
//  Created by Suha Baobaid on 7/4/22.
//

import XCTest
@testable import TrexisProject

class DashboardTests: XCTestCase {
    
    var sut: DashboardViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DashboardViewModel(apiService: APIService())
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testGetAccounts() {
        
        var resultAccounts: [Account] = []
        // Create the expectation.
        let expectation = self.expectation(description: "Waiting for the getting accounts call to complete.")
        
        
        sut.getAccounts { accounts in
            resultAccounts = accounts
            expectation.fulfill()
        }
        
        // Wait for expectations for a maximum of 2 seconds.
        waitForExpectations(timeout: 2) { error in
            XCTAssertNil(error)
            XCTAssertEqual(resultAccounts.count, 3)
        }
    }
    
    func testGetTransactionsForAnExistingAccount() {
        var resultTransactions: [Transaction] = []
        // Create the expectation.
        let expectation = self.expectation(description: "Waiting for the getting transactions call to complete.")
        
        
        sut.getTransactions(forAccountID: "1") { transactions in
            resultTransactions = transactions
            expectation.fulfill()
        }
        
        // Wait for expectations for a maximum of 2 seconds.
        waitForExpectations(timeout: 2) { error in
            XCTAssertNil(error)
            XCTAssertEqual(resultTransactions.count, 3)
        }
    }
    
    func testGetTransactionsForAnInvalidAccount() {
        var resultTransactions: [Transaction] = []
        // Create the expectation.
        let expectation = self.expectation(description: "Waiting for the getting transactions call to complete.")
        
        
        sut.getTransactions(forAccountID: "4") { transactions in
            resultTransactions = transactions
            expectation.fulfill()
        }
        
        // Wait for expectations for a maximum of 2 seconds.
        waitForExpectations(timeout: 2) { error in
            XCTAssertNil(error)
            XCTAssertEqual(resultTransactions.count, 0)
        }
    }
    
}
