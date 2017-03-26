//
//  DetailIngredientCell.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 25/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

extension IngredientTableViewCell: PricedItemCell {
    
    func set(name: String) {
        
        self.titleLabel.text = name
    }
}
