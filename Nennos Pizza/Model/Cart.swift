//
//  Cart.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 26/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

struct Cart {
    
    var pizzas = Array<Pizza>()
}

fileprivate typealias MutableCart = Cart

extension MutableCart {
    
    mutating func insert(pizza: Pizza) {
        
        self.pizzas.append(pizza)
    }
    
    mutating func removePizza(at index: Int) -> Bool {
        
        guard self.pizzas.count > index else {
            return false
        }
        
        self.pizzas.remove(at: index)
        return true
    }
}
