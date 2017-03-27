//
//  Pizza_Tests.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 27/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import XCTest
@testable import Nennos_Pizza

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
        let serializedPizza = pizza.serialize()
        
        self.extendedPizzaDictionary.forEach { (key, value) in
            
            if let value = value as? String {
            
                XCTAssert(value == serializedPizza[key] as? String, "Serialization error invalid value \(key)")
                
            } else if let value = value as? Array<Int> {
            
                guard let serializedValue = serializedPizza[key] as? Array<Int> else {
                    
                    return XCTFail("Serialization error invalid value \(key)")
                }
                
                value.forEach({ (item) in
                    XCTAssertNotNil(serializedValue.index(of: item), "Ingredient id not found \(item)")
                })
            }
            
        }
        
        
    }
}
