//
//  MainTableViewCell.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 25/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    //Model
    weak var delegate: MainTableViewCellDelegate?
    
    //View
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var detailsContainerView: UIView!
    @IBOutlet weak var buyButton: PriceControl!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addBlurEffect()
        self.prepareCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.prepareCell()
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
    
    private func prepareCell() {
        
        self.titleLabel.font = UIFont.titleFont
        self.titleLabel.textColor = UIColor.textColor
        self.titleLabel.text = ""
        
        self.descriptionLabel.font = UIFont.textFont
        self.descriptionLabel.textColor = UIColor.textColor
        self.descriptionLabel.text = ""
        
        self.mainImageView.image = nil
    }
    
    @IBAction func buyPressedAction(_ sender: Any) {
        
        self.delegate?.didPressedBuy(for: self)
    }
}

protocol MainTableViewCellDelegate: class {
    
    func didPressedBuy(for cell: MainTableViewCell)
    
}
