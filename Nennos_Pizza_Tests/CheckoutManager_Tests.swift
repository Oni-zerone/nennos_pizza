//
//  Nennos_Pizza_Tests.swift
//  Nennos_Pizza_Tests
//
//  Created by Andrea Altea on 27/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import XCTest

class CheckoutManager_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCompletion() {
    
        let expect = expectation(description: "POST cart")
        
        let cart = Cart()
        CheckoutManager.send(cart) { (success, error) in
            
            expect.fulfill()
        }
        waitForExpectations(timeout: 10) { error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            
        }

    }
    
}
