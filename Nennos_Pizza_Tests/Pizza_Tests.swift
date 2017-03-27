//
//  Pizza_Tests.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 27/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import XCTest

class Pizza_Tests: XCTestCase {
    
    var pizzaDictionary: Dictionary<String, Any>!
    
    override func setUp() {
        super.setUp()
        
        pizzaDictionary = ["name" : "Pizza",
                           "ingredients" : [1, 2, 4, 5]]
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    func testBasePizza() {
        
        guard let pizza = Pizza(resource: self.pizzaDictionary) else {
            
            return XCTFail("Pizza not initialized.")
        }
     
        self.basePizzaTests(for: pizza)
    }
    
    func testFullPizza() {
        
        guard var extendedPizza = self.pizzaDictionary else {
            
            return XCTFail("Invalid base dictionary.")
        }
        extendedPizza["imageUrl"] = "http://www.google.com"
        
        guard let pizza = Pizza(resource: extendedPizza) else {
            
            return XCTFail("Pizza not initialized.")
        }
        
        basePizzaTests(for: pizza)
        
        XCTAssert(pizza.imageUrl == extendedPizza["imageUrl"] as? String)
        
    }
    
    func basePizzaTests(for pizza: Pizza) {
        
        XCTAssert(pizza.name == self.pizzaDictionary["name"] as? String, "Invalid name parameter.")
        XCTAssert(pizza.ingredientIds == Set(self.pizzaDictionary["ingredients"] as! Array<Int>), "Invalid ingredients array.")
    }
}
