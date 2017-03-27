//
//  PriceableItem.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 26/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

protocol PriceableItem {
    
    var currency: String? { get }
    func setPrice(with string: String)
    
    func set(price: Double)
}

extension PriceableItem {
    
    func set(price: Double) {
        
        if price <= 0 {
            return setPrice(with: "")
        }
        
        var priceString = currency ?? String()
        priceString += String(format: " %.2f", price)
        return setPrice(with: priceString)
    }
}
