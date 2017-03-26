//
//  BigPriceControl.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 26/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

@IBDesignable class BigPriceControl: UIControl {

    fileprivate let baseString = "Add to cart"
    fileprivate weak var priceLabel: UILabel!
    
    @IBInspectable var currency: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.setupLayout()
    }
    
    func setupLayout() {
     
        //Setup label
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = self.tintColor
        label.font = UIFont.buttonFont
        label.textAlignment = .center
        
        self.addSubview(label)
        
        //View Constraints
        let metrics = ["margin" : 15]
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat:"|-margin-[view]-margin-|",
                                                          options: NSLayoutFormatOptions(rawValue: 0),
                                                          metrics: metrics,
                                                          views: ["view" : label]);
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat:"V:|-margin-[view]-margin-|",
                                                          options: NSLayoutFormatOptions(rawValue: 0),
                                                          metrics: metrics,
                                                          views: ["view" : label]);
        self.addConstraints(hConstraints);
        self.addConstraints(vConstraints);
        
    }
    
    override var tintColor: UIColor! {
        
        didSet {
            self.priceLabel.textColor = self.tintColor
        }
    }
}

extension BigPriceControl: PriceableItem {
    
    func setPrice(with string: String) {
        
        if string.characters.count < 1 {
            self.priceLabel.text = self.baseString
            return
        }
        
        self.priceLabel.text = String(format: "%@ (%@)", self.baseString, string)
    }
}
