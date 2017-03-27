//
//  ShippableDrink.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 27/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

extension Drink: ShippableReference {
    
    func getPrice(completion: @escaping (Double) -> ()) {
        
        DispatchQueue.main.async {
            completion(self.price)
        }
        return
    }
    
    func serialize() -> Int {
        
        return self.id
    }
}
