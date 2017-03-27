//
//  PriceableItem.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 27/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

protocol PricedItem {
    
    var name: String { get }
    var price: Double { get }
}
