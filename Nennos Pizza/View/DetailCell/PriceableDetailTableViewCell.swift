//
//  PriceableDetailTableViewCell.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 26/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

fileprivate typealias PriceableDetailTableViewCell = DetailTableViewCell

extension PriceableDetailTableViewCell: PriceableItem {
    
    var currency: String? {
        get  {
            return "$"
        }
    }

    func setPrice(with string: String) {
        self.detailLabel.text = string
    }
    
}
