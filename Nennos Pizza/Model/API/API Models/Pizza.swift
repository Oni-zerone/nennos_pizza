//
//  Pizza.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 24/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

struct Pizza {
    
    static var basePrice: Double = 0
    
    let name: String
    let ingredientIds: Array<Int>
    let imageUrl: String?
    
    init?(resource: Dictionary<String, Any>) {
        
        guard let name = resource["name"] as? String else {
            return nil
        }
        self.name = name
        self.imageUrl = resource["imageUrl"] as? String
        var ingredients = Array<Int>()
        
        if let items = resource["ingredients"] as? Array<Int> {

            ingredients.append(contentsOf: items);
        }
        
        self.ingredientIds = ingredients
    }
}
