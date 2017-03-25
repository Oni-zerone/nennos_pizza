//
//  PriceControl.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 25/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

@IBDesignable class PriceControl: UIControl {

    private weak var cartImageView: UIImageView!
    private weak var pricelabel: UILabel!
    
    override var tintColor: UIColor! {
        didSet {
            self.pricelabel.textColor = self.tintColor
        }
    }
    
    @IBInspectable var currency : String?

    @IBInspectable var cartImage: UIImage? {
        
        set {
            self.cartImageView.image = newValue?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        }
        
        get {
            return self.cartImageView.image
        }
    }

    
    var price: Double? {
        
        didSet {

            guard let price = self.price else {
                
                self.pricelabel.text = ""
                return
            }
            
            var priceString = String()
            
            if let currency = self.currency {
                priceString += "\(currency) "
            }
            
            priceString += String(format: "%.2f", price)
            self.pricelabel.text = priceString
        }
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame);
        
        setupLayout();
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        
        setupLayout();
    }
    
    private func setupLayout() {
        
        //Setup cartImageView
        let cartImageView = UIImageView()
        cartImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cartImageView)
        
        //Setup priceLabel
        let priceLabel = UILabel()
        priceLabel.textAlignment = .right
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(priceLabel)
        
        //Setup constaints
        let views = ["cartImageView" : cartImageView, "priceLabel" : priceLabel]
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat:"H:|-8-[cartImageView]-4-[priceLabel(>=30)]-8-|",
                                                          options: NSLayoutFormatOptions(rawValue: 0),
                                                          metrics: nil,
                                                          views:views)
        let vCartConstraints = NSLayoutConstraint.constraints(withVisualFormat:"V:|-0-[cartImageView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        let priceLabelConstraint = NSLayoutConstraint(item: priceLabel, attribute: .bottom, relatedBy: .equal, toItem: cartImageView, attribute: .bottom, multiplier: 1, constant: 0)
        
        self.addConstraint(priceLabelConstraint)
        self.addConstraints(vCartConstraints)
        self.addConstraints(hConstraints)
        
        //Setup background radius
        self.clipsToBounds = true
        self.layer.cornerRadius = 4
    }
}
