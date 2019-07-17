//
//  FilteringMatchesTests.swift
//  FilteringMatchesTests
//
//  Created by Gaditek on 17/07/2019.
//  Copyright © 2019 Munib Siddiqui. All rights reserved.
//

import XCTest
@testable import FilteringMatches

class FilteringMatchesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    
    func testGetAllUserList () {
        
        let expectation = self.expectation(description: "ListOfMatchs")
        var localusers: [User]?

        NetworkManager.sharedInstance.getAllUser(onSuccess: { (users) in
            
            localusers = users
            
            expectation.fulfill()

        }) { (error) in
            expectation.fulfill()

        }
        
        waitForExpectations(timeout: 30, handler: nil)
        
        XCTAssert(localusers!.count > 0);

        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
