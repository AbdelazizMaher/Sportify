//
//  SportifyTests.swift
//  SportifyTests
//
//  Created by Abdelaziz on 29/05/2025.
//

import XCTest
@testable import Sportify

final class SportifyTests: XCTestCase {
    var service : NetworkServiceCM!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        service = NetworkServiceCM()
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
    
    //test football//////
    func testGetFootballData(){
            let exp = expectation(description: "waiting for Api")
            service.fetchDataFromApi(sport: "football", met: "Leagues") { (result: [League]?) in

                XCTAssert(result?.count == 943)
                exp.fulfill()

            }
            waitForExpectations(timeout: 5)

        }
    
    func testGetFootballTeams(){
            let exp = expectation(description: "waiting for Api")
            service.fetchDataFromApi(sport: "football", met: "Teams",teamId: "96") { (result: [Team]?) in

                XCTAssert(result?[0].teamName == "Juventus")
                exp.fulfill()

            }
            waitForExpectations(timeout: 5)

        }
 
    
    //test basketBall
    func testGetBasketballData(){
            let exp = expectation(description: "waiting for Api")
            service.fetchDataFromApi(sport: "basketball", met: "Leagues") { (result: [League]?) in

                XCTAssert(result?.count == 531)
                exp.fulfill()

            }
            waitForExpectations(timeout: 5)

        }
    
    
    func testGetBasketballTeams(){
            let exp = expectation(description: "waiting for Api")
            service.fetchDataFromApi(sport: "basketball",  met: "Teams",teamId: "96") { (result: [Team]?) in

                XCTAssert(result?[0].teamName == "Ludwigsburg")
                exp.fulfill()

            }
            waitForExpectations(timeout: 5)

        }
    
    //test tennis
    func testGetTennisData(){
            let exp = expectation(description: "waiting for Api")
            service.fetchDataFromApi(sport: "tennis", met: "Leagues") { (result: [League]?) in

                XCTAssert(result?.count == 8905)
                exp.fulfill()

            }
            waitForExpectations(timeout: 10)

        }
    
    
    
    //test Cricket
    func testGetCricket(){
            let exp = expectation(description: "waiting for Api")
            service.fetchDataFromApi(sport: "cricket", met: "Leagues") { (result: [League]?) in

                XCTAssert(result?.count == 702)
                exp.fulfill()

            }
            waitForExpectations(timeout: 5)

        }
    
    func testGetCricketTeams(){
            let exp = expectation(description: "waiting for Api")
            service.fetchDataFromApi(sport: "cricket", met: "Teams",teamId: "138") { (result: [Team]?) in

                XCTAssert(result?[0].teamName == "Barbados Cricket Association President's XI" &&  result?[0].teamKey == 138)
                exp.fulfill()

            }
            waitForExpectations(timeout: 5)

        }

}
