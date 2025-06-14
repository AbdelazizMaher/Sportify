//
//  MockReachability.swift
//  SportifyTests
//
//  Created by Abdelaziz on 04/06/2025.
//

import XCTest
@testable import Sportify

final class MockReachability: XCTestCase {

    var fakeObj1 : FakeNetworkService!
    var fakeObj2 : FakeNetworkService!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        fakeObj1 = FakeNetworkService(shouldReturnError: NetworkManager.isInternetAvailable())
        fakeObj2 = FakeNetworkService(shouldReturnError: !NetworkManager.isInternetAvailable())
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
    
    func testMockReachabilityTrue() {
        let expectation = self.expectation(description: "Expect error response")

        fakeObj1.fetchDataFromApi(sport: "football", met: "Leagues") { (leagues: [League]?) in
            XCTAssertNil(leagues)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testMockReachabilityFalse() {
        let expectation = self.expectation(description: "Expect valid leagues array")

        fakeObj2.fetchDataFromApi(sport: "football", met: "Leagues") { (leagues: [League]?) in
            XCTAssertNotNil(leagues)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }
}



