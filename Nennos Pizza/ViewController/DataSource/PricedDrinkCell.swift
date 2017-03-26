//
//  DetailDrinkCell.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 27/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

extension DrinkTableViewCell: PricedItemCell {
    
    func set(name: String) {
        
        self.titleLabel.text = name
    }
}
