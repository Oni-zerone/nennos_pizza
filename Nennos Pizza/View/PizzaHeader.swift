//
//  PizzaHeader.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 25/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

class PizzaHeader: UIView {

    static private let headerHeight : CGFloat = 300.0
    
    weak var backgroundImageView: UIImageView!
    weak var pizzaImageView: UIImageView!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.setupViews()
    }
    
    private func setupViews() {

        self.setupBackground()
        self.setupPizza()
    }
    
    private func setupBackground() {
        
        let background = UIImageView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.clipsToBounds = true
        self.addSubview(background)
        background.contentMode = .scaleAspectFill

        self.backgroundImageView = background
        
        let metrics = ["headerHeight": PizzaHeader.headerHeight]
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "|-0-[backgroundView]-0-|",
                                                              options: NSLayoutFormatOptions(rawValue: 0),
                                                              metrics: nil,
                                                              views: ["backgroundView" : background]);
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[backgroundView(==headerHeight)]-0-|",
                                                              options: NSLayoutFormatOptions(rawValue: 0),
                                                              metrics: metrics,
                                                              views: ["backgroundView" : background]);
        self.addConstraints(hConstraints);
        self.addConstraints(vConstraints);
    }
    
    private func setupPizza() {
        
        let content = UIImageView()
        content.translatesAutoresizingMaskIntoConstraints = false
        content.clipsToBounds = true
        self.addSubview(content)
        content.contentMode = .scaleAspectFit

        self.pizzaImageView = content
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "|[pizzaView]|",
                                                          options: NSLayoutFormatOptions(rawValue: 0),
                                                          metrics: nil,
                                                          views: ["pizzaView" : content]);
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[pizzaView]|",
                                                          options: NSLayoutFormatOptions(rawValue: 0),
                                                          metrics: nil,
                                                          views: ["pizzaView" : content]);
        
        self.addConstraints(hConstraints)
        self.addConstraints(vConstraints)
    }
    
    func insert(in scrollView: UIScrollView) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(self)
        
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "|-0-[pizzaHeader(==scrollView)]-0-|",
                                                          options: NSLayoutFormatOptions(rawValue: 0),
                                                          metrics: nil,
                                                          views: ["pizzaHeader" : self, "scrollView" : scrollView]);
        let vConstraint = NSLayoutConstraint(item: scrollView,
                                             attribute: .top,
                                             relatedBy: .equal,
                                             toItem: self,
                                             attribute: .bottom,
                                             multiplier: 1,
                                             constant: 0)
        
        scrollView.addConstraints(hConstraints);
        scrollView.addConstraint(vConstraint);
        
        let oldInset = scrollView.contentInset
        scrollView.contentInset = UIEdgeInsetsMake(oldInset.top + PizzaHeader.headerHeight, oldInset.left, oldInset.bottom, oldInset.right)
    }
}
