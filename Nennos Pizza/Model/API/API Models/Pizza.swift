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
    private(set) var ingredients: Array<Ingredient>
    let imageUrl: String?
    
    init?(resource: Dictionary<String, Any>) {
        
        guard let name = resource["name"] as? String else {
            return nil
        }
        self.name = name
        self.imageUrl = resource["imageUrl"] as? String
        self.ingredients = Array<Ingredient>()
        
        if let ingredients = resource["ingredients"] as? Array<Dictionary<String, Any >> {

            self.ingredients.append(contentsOf: ingredients.flatMap({ (ingredient) -> Ingredient? in
                return Ingredient(resource: ingredient)
            }))
        }
    }
}
