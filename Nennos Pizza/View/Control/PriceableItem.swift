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
    var priceString: String { get set }
    
    func set(price: Double)
    
}
