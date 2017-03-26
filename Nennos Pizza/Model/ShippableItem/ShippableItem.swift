//
//  ShippableItem.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 26/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

protocol ShippableItem {
    
    var name: String { get }
    func getPrice(completion: @escaping (Double) -> ())
}
