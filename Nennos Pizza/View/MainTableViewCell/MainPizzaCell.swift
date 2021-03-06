//
//  MainPizzaCell.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 25/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

extension MainTableViewCell: PizzaCell {
    
    typealias Delegate = MainTableViewCellDelegate
    
    func set(name: String) {
        
        self.titleLabel.text = name
    }
    
    func set(ingredients: String) {
        
        self.descriptionLabel.text = ingredients
    }
    
    func set(image: UIImage) {
        
        self.mainImageView.image = image
    }
    
    func set(price: Double) {
        
        self.buyButton.set(price: price)
    }
    
    func set(delegate: AnyObject?) {
        
        guard let cellDelegate = delegate as? MainTableViewCellDelegate else {
            self.delegate = nil
            return
        }
        
        self.delegate = cellDelegate
    }
}
