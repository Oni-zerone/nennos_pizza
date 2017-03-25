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
    private weak var priceLabel: UILabel!
    
    override var tintColor: UIColor! {
        didSet {
            self.priceLabel.textColor = self.tintColor
        }
    }
    
    @IBInspectable var currency : String?

    @IBInspectable var cartImage: UIImage? {
        
        didSet {
            self.cartImageView.image = self.cartImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        }
    }

    var price: Double? {
        
        didSet {

            guard let price = self.price else {
                
                self.priceLabel.text = ""
                return
            }
            
            var priceString = currency ?? String()
            priceString += String(format: " %.2f", price)
            
            self.priceLabel.text = priceString
        }
    }
    
    required override init(frame: CGRect) {

        super.init(frame: frame);
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder);
        setupLayout()
    }
    
    private func setupLayout() {
        
        //Setup cartImageView
        print(self.cartImage?.description ?? "NO CART IMAGE")
        let cartImageView = UIImageView(image: self.cartImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate))
        cartImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cartImageView)
        self.cartImageView = cartImageView
        
        
        //Setup priceLabel
        let priceLabel = UILabel()
        priceLabel.textAlignment = .right
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(priceLabel)
        self.priceLabel = priceLabel
        
        //Setup constaints
        let views = ["cartImageView" : cartImageView, "priceLabel" : priceLabel] as Dictionary<String, UIView>
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
