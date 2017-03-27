//
//  ShippablePizza.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 26/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

fileprivate typealias ShippablePizza = Pizza

extension ShippablePizza: ShippableObject {
    
    func getPrice(completion: @escaping (Double) -> ()) {
        
        Model.shared.getPrice(for: self) { (price) in
            
            completion(price)
        }
        
    }
    
    func serialize() -> Dictionary<String, Any> {
        
        var serializedItem = Dictionary<String, Any>()
        serializedItem["name"] = self.name
        serializedItem["ingredients"] = Array<Int>(self.ingredientIds)
        serializedItem["imageUrl"] = self.imageUrl
        
        return serializedItem
    }
}
