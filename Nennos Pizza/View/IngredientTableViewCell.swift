//
//  IngredientTableViewCell.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 25/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    @IBOutlet weak var checkImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.setupLabels()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.setupLabels()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.checkImageView.isHidden = !selected
    }
    
    func setupLabels() {
        
        self.titleLabel.text = ""
        self.titleLabel.font = UIFont.detailFont
        self.titleLabel.textColor = UIColor.textColor
        
        self.detailLabel.text = ""
        self.titleLabel.font = UIFont.detailFont
        self.titleLabel.textColor = UIColor.textColor
        
        self.checkImageView.tintColor = UIColor.primaryColor
    }
    
}
