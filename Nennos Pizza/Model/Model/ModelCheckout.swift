//
//  ModelCheckout.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 27/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

fileprivate typealias ModelCheckout = Model

extension ModelCheckout {

    internal func send(_ cart: Cart, completion: @escaping (Bool) -> ()) {
        
        CheckoutManager.send(cart) { (success, error) in
            
            if error != nil {
                completion(false)
                return
            }
            self.cart = Cart()
            
            completion(success)
            return
        }
        
    }
    
}
