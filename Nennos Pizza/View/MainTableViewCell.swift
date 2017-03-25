//
//  MainTableViewCell.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 25/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    //View
    @IBOutlet weak var pizzaLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    @IBOutlet weak var pizzaImageView: UIImageView!
    @IBOutlet weak var detailsContainerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addBlurEffect()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.pizzaLabel.text = ""
        self.ingredientsLabel.text = ""
        self.pizzaImageView.image = nil
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func addBlurEffect() {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false;
        
        self.detailsContainerView.addSubview(blurEffectView)
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "|-0-[view]-0-|",
                                                          options: NSLayoutFormatOptions(rawValue: 0),
                                                          metrics: nil,
                                                          views: ["view" : blurEffectView])
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|",
                                                          options: NSLayoutFormatOptions(rawValue: 0),
                                                          metrics: nil,
                                                          views: ["view" : blurEffectView])
        
        self.detailsContainerView.addConstraints(hConstraints)
        self.detailsContainerView.addConstraints(vConstraints)
        
        self.detailsContainerView.sendSubview(toBack: blurEffectView)
    }
    
}
