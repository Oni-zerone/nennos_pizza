//
//  ShippablePizza.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 26/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

fileprivate typealias ShippablePizza = Pizza

extension ShippablePizza: ShippableItem {
    
    func getPrice(completion: @escaping (Double) -> ()) {
        
        Model.shared.getPrice(for: self) { (price) in
            
            completion(price)
        }
        
    }
}
