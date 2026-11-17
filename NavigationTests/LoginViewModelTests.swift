//
//  LoginViewModelTests.swift
//  NavigationTests
//
//  Created by Mysty Mystylal on 16.11.2026.
//

import XCTest
@testable import Navigation

final class LoginDelegateMock: LoginViewControllerDelegate {
    var checkResult: Result<Void, Error> = .success(())
    var signUpResult: Result<Void, Error> = .success(())
    
    func checkCredentials(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        completion(checkResult)
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        completion(signUpResult)
    }
}

final class LoginViewModelTests: XCTestCase {

    func test_login_resultsInFailure_email(){
        let viewModel = LoginViewModel(loginDelegate: LoginDelegateMock())
        viewModel.logIn(email: "", password: "test556")
        XCTAssertEqual(viewModel.state, .failure(message: NSLocalizedString("login.enter_username", comment: "")))
    }
    
    func test_login_resultsInFailure_password(){
        let viewModel = LoginViewModel(loginDelegate: LoginDelegateMock())
        viewModel.logIn(email: "test@test.com", password: "556")
        XCTAssertEqual(viewModel.state, .failure(message:String(format: NSLocalizedString("login.password_too_short", comment: ""),6)))
    }
    
    func test_login_resultsInSuccess(){
        let delegate = LoginDelegateMock()
        delegate.checkResult = .success(())
        let viewModel = LoginViewModel(loginDelegate: delegate)
        viewModel.logIn(email: "test@test.com", password: "test556")
        XCTAssertEqual(viewModel.state, .success)
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
