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
    fileprivate(set) var ingredientIds: Set<Int>
    let imageUrl: String?
    
    init?(resource: Dictionary<String, Any>) {
        
        guard let name = resource["name"] as? String else {
            return nil
        }
        self.name = name
        self.imageUrl = resource["imageUrl"] as? String
        self.ingredientIds = Set((resource["ingredients"] as? Array<Int>) ?? Array<Int>())
    }
}

extension Pizza: Hashable {
    
    var hashValue: Int {
        
        get {
            return self.name.hash
        }
    }
    
    public static func ==(lhs: Pizza, rhs: Pizza) -> Bool {
        
        return lhs.ingredientIds == rhs.ingredientIds;
    }
}

fileprivate typealias MutablePizza = Pizza

extension MutablePizza {
    
    mutating func add(ingredient: Ingredient) {
        
        self.ingredientIds.insert(ingredient.id)
    }
    
    mutating func remove(ingredient: Ingredient) {
        
        self.ingredientIds.remove(ingredient.id)
    }
}
