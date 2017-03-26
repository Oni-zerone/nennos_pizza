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
    fileprivate weak var priceLabel: UILabel!

    @IBInspectable var currency: String?
    @IBInspectable var cartImage: UIImage? {
        
        didSet {
            self.cartImageView.image = self.cartImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
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

    override var tintColor: UIColor! {
        didSet {
            self.priceLabel.textColor = self.tintColor
        }
    }
    
    private func setupLayout() {
        
        setupCartImageView()
        setupPriceLabel()
        
        //Setup constaints
        let views = ["cartImageView" : cartImageView, "priceLabel" : priceLabel] as Dictionary<String, UIView>
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat:"H:|-8-[cartImageView(24)]-4-[priceLabel(>=30)]-8-|",
                                                          options: NSLayoutFormatOptions(rawValue: 0),
                                                          metrics: nil,
                                                          views:views)
        let vCartConstraints = NSLayoutConstraint.constraints(withVisualFormat:"V:|-0-[cartImageView(24)]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        let priceLabelConstraint = NSLayoutConstraint(item: priceLabel, attribute: .bottom, relatedBy: .equal, toItem: cartImageView, attribute: .bottom, multiplier: 1, constant: 0)
        
        self.addConstraint(priceLabelConstraint)
        self.addConstraints(vCartConstraints)
        self.addConstraints(hConstraints)
        
        //Setup background radius
        self.clipsToBounds = true
        self.layer.cornerRadius = 4
    }
    
    private func setupCartImageView() {

        let cartImageView = UIImageView(image: self.cartImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate))
        cartImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cartImageView)
        self.cartImageView = cartImageView
    }
    
    private func setupPriceLabel() {
        
        let priceLabel = UILabel()
        priceLabel.textAlignment = .right
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textColor = self.tintColor
        priceLabel.font = UIFont.buttonFont
        self.addSubview(priceLabel)
        self.priceLabel = priceLabel
    }
}

extension PriceControl: PriceableItem {
    
    func setPrice(with string: String) {
        
        self.priceLabel.text = string
    }
}
