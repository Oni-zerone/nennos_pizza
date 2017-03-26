//
//  NotificationViewController.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 26/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {
    
    private var notificationsCount: UInt = 0 {
        
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        
        get {
            return self.notificationsCount > 0;
        }
        
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        
        get {
            return .slide;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didAddPizza(with:)),
                                               name: Cart.Notifications.didAddItem,
                                               object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self,
                                                  name: Cart.Notifications.didAddItem,
                                                  object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func didAddPizza(with notification: Notification) {
        
        let notificationView = self.prepareNotificationView()
        self.view.addSubview(notificationView)
        //Append
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "|-0-[view]-0-|",
                                                          options: NSLayoutFormatOptions(rawValue: 0),
                                                          metrics: nil,
                                                          views: ["view" : notificationView]);
        let vConstraint = NSLayoutConstraint(item: notificationView,
                                             attribute: .bottom,
                                             relatedBy: .equal,
                                             toItem: self.view,
                                             attribute: .top,
                                             multiplier: 1,
                                             constant: 0)
        
        self.view.addConstraints(hConstraints);
        self.view.addConstraint(vConstraint);
        
        self.animateNotificaitonView(notificationView)
    }
    
    private func prepareNotificationView() -> UIView {
        
        let label = UILabel()
        label.backgroundColor = UIColor.primaryColor
        label.textColor = UIColor.white
        label.font = UIFont.notificationFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "ADDED TO CART"
        
        let heightConstraint = NSLayoutConstraint(item: label,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1,
                                                  constant: 20)
        label.addConstraint(heightConstraint)
        return label
    }
    
    func animateNotificaitonView(_ notificationView: UIView) {
        
        self.view.layoutIfNeeded()
        self.notificationsCount += 1
        
        UIView.animateKeyframes(withDuration: 3.2, delay: 0, options: .allowUserInteraction, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.1, animations: {
                
                notificationView.transform = CGAffineTransform(translationX: 0, y: notificationView.frame.height)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.96, relativeDuration: 0.1, animations: {
                notificationView.transform = CGAffineTransform.identity
            })
            
        }) { (finished) in
            self.notificationsCount -= 1
            notificationView.removeFromSuperview()
        }
    }
}
