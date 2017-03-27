//
//  CartCell.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 26/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

enum CartCellMode {

    case item
    case total
}

protocol CartCell {
    
    func set(name: String)
    func set(price: Double)
    
    func setup(_ mode: CartCellMode)
}
