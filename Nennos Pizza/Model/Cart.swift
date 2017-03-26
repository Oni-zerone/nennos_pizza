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
    
    struct Notifications {
        
        static let didAddPizza = Notification.Name("it.studiout.NennosPizza.Cart.didAddPizza")
    }
}

fileprivate typealias MutableCart = Cart

extension MutableCart {
    
    mutating func insert(pizza: Pizza) {
        
        self.pizzas.append(pizza)

        DispatchQueue.main.async {
            NotificationCenter.default.post(name: Cart.Notifications.didAddPizza, object: self)
        }
    }
    
    mutating func removePizza(at index: Int) -> Bool {
        
        guard self.pizzas.count > index else {
            return false
        }
        
        self.pizzas.remove(at: index)
        return true
    }
}
