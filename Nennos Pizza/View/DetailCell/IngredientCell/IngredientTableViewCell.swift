//
//  IngredientTableViewCell.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 25/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

class IngredientTableViewCell: DetailTableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle(rawValue: 0)!, reuseIdentifier: reuseIdentifier)
        
        self.setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupSubViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.itemImageView.isHidden = !selected
    }
    
    
    func setupSubViews() {
        
        self.itemImageView.image = #imageLiteral(resourceName: "Check").withRenderingMode(.alwaysTemplate)
        self.selectionStyle = .none
    }
}
