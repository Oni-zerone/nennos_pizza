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
    var extendedPizzaDictionary: Dictionary<String, Any>!
    
    override func setUp() {
        super.setUp()
        
        pizzaDictionary = ["name" : "Pizza",
                           "ingredients" : [1, 2, 4, 5]]
        
        extendedPizzaDictionary = ["name" : "Pizza",
                                   "ingredients" : [1, 2, 4, 5],
                                   "imageUrl" : "http://www.google.com"]
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    func testBasePizza() {
        
        guard let pizza = Pizza(resource: self.pizzaDictionary) else {
            
            return XCTFail("Pizza not initialized.")
        }
     
        self.basePizzaTests(for: pizza, with: self.pizzaDictionary)
    }
    
    func testFullPizza() {
        
        
        guard let pizza = Pizza(resource: self.extendedPizzaDictionary) else {
            
            return XCTFail("Pizza not initialized.")
        }
        
        basePizzaTests(for: pizza, with: extendedPizzaDictionary)
        
        XCTAssert(pizza.imageUrl == self.extendedPizzaDictionary["imageUrl"] as? String)
        
    }
    
    func basePizzaTests(for pizza: Pizza, with dictionary: Dictionary<String, Any>) {
        
        XCTAssert(pizza.name == self.pizzaDictionary["name"] as? String, "Invalid name parameter.")
        XCTAssert(pizza.ingredientIds == Set(self.pizzaDictionary["ingredients"] as! Array<Int>), "Invalid ingredients array.")
    }
    
    func testSerializePizza() {
        
        guard let pizza = Pizza(resource: self.extendedPizzaDictionary) else {

            return XCTFail("Pizza not initialized.")
        }
        
        guard let serializedPizza = pizza.serialize() else {
        
            return XCTFail("Serialization failed.")
        }
        XCTAssert(serializedPizza.0 == "pizzas", "Serialization error invalid key")
        XCTAssert(NSDictionary(dictionary:serializedPizza.1).isEqual(to: self.extendedPizzaDictionary), "Serialization error invalid value")
    }
}
