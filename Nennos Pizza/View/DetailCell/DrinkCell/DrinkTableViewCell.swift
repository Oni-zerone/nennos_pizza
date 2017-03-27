//
//  DrinkTableViewCell.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 27/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

class DrinkTableViewCell: DetailTableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle(rawValue: 0)!, reuseIdentifier: reuseIdentifier)
        
        self.setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupSubViews()
    }
    
    func setupSubViews() {
        
        self.itemImageView.image = #imageLiteral(resourceName: "Add").withRenderingMode(.alwaysTemplate)
        self.selectionStyle = .none
    }
}
