//
//  FeedViewModelTests.swift
//  NavigationTests
//
//  Created by Mysty Mystylal on 16.11.2026.
//

import XCTest
@testable import Navigation

final class FeedModelMock: FeedModelProtocol {
    var fakeResult: Bool = false
    func check(word: String, end: @escaping (Bool) -> Void) {
        end(fakeResult)
    }
}
final class FeedViewModelTests: XCTestCase {
    
    func test_sanity() {
          XCTAssertTrue(true)
      }
    
    func test_checkword_resultsInError() {
        let mock = FeedModelMock()
        let viewModel = FeedViewModel(feedModel: mock)
        viewModel.check(word: "")
        XCTAssertEqual(viewModel.state, .error)
    }
    func test_checkword_resultsInCheckedTrue(){
        let mock = FeedModelMock()
        mock.fakeResult = true
        let viewModel = FeedViewModel(feedModel: mock)
        viewModel.check(word: "vadim")
        XCTAssertEqual(viewModel.state, .checked(result: true))
    }
    func test_checkword_resultsInCheckedFalse() {
        let mock = FeedModelMock()
        mock.fakeResult = false
        let viewModel = FeedViewModel(feedModel: mock)
        viewModel.check(word: "meow")
        XCTAssertEqual(viewModel.state, .checked(result: false))
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
