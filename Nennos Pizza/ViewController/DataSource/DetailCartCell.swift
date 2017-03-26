//
//  DetailCartCell.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 26/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

extension CartTableViewCell: CartCell {
    
    func set(name: String) {
        
        self.titleLabel.text = name
    }
}
