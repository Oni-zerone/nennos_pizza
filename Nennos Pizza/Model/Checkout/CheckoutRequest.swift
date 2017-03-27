//
//  CheckoutRequest.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 27/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

class CheckoutRequest: NSMutableURLRequest {

    required override init(url URL: URL, cachePolicy: NSURLRequest.CachePolicy, timeoutInterval: TimeInterval) {
        
        super.init(url: URL, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        initialize()
    }
    
    private func initialize() {
        
        addValue("application/json", forHTTPHeaderField: "Accept")
        addValue("application/json", forHTTPHeaderField: "Content-Type")
        self.httpMethod = "POST"
    }

    public func register(cart: Cart) throws {
        
        let jsonData = try JSONSerialization.data(withJSONObject: cart.serialize(),
                                                  options: .prettyPrinted)
        self.httpBody = jsonData
    }
    
}
