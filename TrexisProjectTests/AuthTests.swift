//
//  AuthTests.swift
//  TrexisProjectTests
//
//  Created by Suha Baobaid on 7/4/22.
//

import XCTest
@testable import TrexisProject

class AuthTests: XCTestCase {

    var sut: AuthViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = AuthViewModel(apiService: APIService())
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testLoginFormUpdatesValuesSuccessfully() throws {
        let form = sut.getForm(for: .login)
        let username = "morty"
        let password = "smith"
        
        form.formItems[0].valueCompletion?(username)
        form.formItems[1].valueCompletion?(password)
        
        XCTAssertEqual(form.username, username, "Login form items updated successfully")
        XCTAssertEqual(form.password, password, "Login form items updated successfully")
    }
    
    
    func testLoginFormValidity() throws {
        let username = "morty"
        let form = sut.getForm(for: .login)
        
        form.formItems[0].valueCompletion?(username)
        let (isValid, _) = form.isValid()
        
        XCTAssertEqual(isValid, false, "Form is invalid when field is missing")
    }

    func testloginUserWithRightArguments() throws {
        var form = sut.getForm(for: .login)
        form.username = "morty"
        form.password = "smith"
        
        var resultLoggedIn: Bool?
        // Create the expectation.
        let expectation = self.expectation(description: "Waiting for the log in call to complete.")
        
        sut.logInUser { isLoggedIn, message in
            resultLoggedIn = isLoggedIn
            expectation.fulfill()
        }
        
        // Wait for expectations for a maximum of 2 seconds.
        waitForExpectations(timeout: 2) { error in
            XCTAssertNil(error)
            XCTAssertEqual(resultLoggedIn, true)
        }
    }
    
    func testLoginUserWithInvaliduser() throws {
        var form = sut.getForm(for: .login)
        form.username = "m"
        form.password = "smith"
        
        var resultLoggedIn: Bool?
        // Create the expectation.
        let expectation = self.expectation(description: "Waiting for the log in call to complete.")
        
        sut.logInUser { isLoggedIn, message in
            resultLoggedIn = isLoggedIn
            expectation.fulfill()
        }
        
        // Wait for expectations for a maximum of 2 seconds.
        waitForExpectations(timeout: 2) { error in
            XCTAssertNil(error)
            XCTAssertEqual(resultLoggedIn, false)
        }
    }

}
