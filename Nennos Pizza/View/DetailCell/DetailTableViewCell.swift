//
//  DetailTableViewCell.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 26/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle(rawValue: 0)!, reuseIdentifier: reuseIdentifier)
        
        self.setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupSubViews()
    }

    func setupSubViews() {
     
        guard let containedView = Bundle.main.loadNibNamed(String(describing: DetailTableViewCell.self), owner: self, options: nil)?.first as? UIView else {
            return
        }
        
        containedView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containedView)
        
        //Constraints
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "|-0-[view]-0-|",
                                                          options: NSLayoutFormatOptions(rawValue: 0),
                                                          metrics: nil,
                                                          views: ["view" : containedView]);
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|",
                                                          options: NSLayoutFormatOptions(rawValue: 0),
                                                          metrics: nil,
                                                          views: ["view" : containedView]);
        self.addConstraints(hConstraints);
        self.addConstraints(vConstraints);
    }
    
}
