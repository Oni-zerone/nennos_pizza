//
//  LabelControl.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 27/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

@IBDesignable class LabelControl: UIControl {

    var labelString: String  {
        
        get {
            return "CHECKOUT"
        }
    }
    
    weak var label: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupLayout()
    }
    
    fileprivate func setupLayout() {
        
        //Setup label
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = self.tintColor
        label.font = UIFont.buttonFont
        label.textAlignment = .center
        label.text = self.labelString
        
        self.addSubview(label)
        self.label = label
        
        //View Constraints
        let metrics = ["margin" : 15]
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat:"|-margin-[view]-margin-|",
                                                          options: NSLayoutFormatOptions(rawValue: 0),
                                                          metrics: metrics,
                                                          views: ["view" : label])
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat:"V:|-margin-[view]-margin-|",
                                                          options: NSLayoutFormatOptions(rawValue: 0),
                                                          metrics: metrics,
                                                          views: ["view" : label])
        self.addConstraints(hConstraints)
        self.addConstraints(vConstraints)
    }
    
    override var tintColor: UIColor! {
        
        didSet {
            self.label.textColor = self.tintColor
        }
    }
}
