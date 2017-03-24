//
//  Ingredients.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 24/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

struct Ingredient {
    
    let id: Double
    let name: String
    let price: Double
    
    init?(resource: Dictionary<String, Any>) {
        
        guard let id = resource["id"] as? Double,
            let name = resource["name"] as? String,
            let price = resource["price"] as? Double else {
                return nil
        }
        
        self.id = id
        self.name = name
        self.price = price
    }
}
