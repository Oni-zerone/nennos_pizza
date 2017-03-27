//
//  DetailCartCell.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 26/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

extension CartTableViewCell: CartCell {
    
    func set(name: String) {
        
        self.titleLabel.text = name
    }
    
    func setup(_ mode: CartCellMode) {
        
        switch mode {
            
        case .item:
            
            self.titleLabel.font = UIFont.detailFont
            self.itemImageView.isHidden = false
            break
            
        case .total:

            self.titleLabel.font = UIFont.detailBoldFont
            self.itemImageView.isHidden = true
            break
            
        }
    }

}
