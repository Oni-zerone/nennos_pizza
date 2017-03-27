//
//  BigPriceControl.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 26/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

@IBDesignable class PriceLabelControl: LabelControl {

    override var labelString: String {
        
        get {
            return "ADD TO CART"
        }
    }
    
    @IBInspectable var currency: String?
    
}

extension PriceLabelControl: PriceableItem {
    
    func setPrice(with string: String) {
        
        if string.characters.count < 1 {
            self.label.text = self.labelString
            return
        }
        
        self.label.text = String(format: "%@ (%@)", self.labelString, string)
    }
}
