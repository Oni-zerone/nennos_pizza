//
//  APIRequest.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 24/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

internal class APIRequest: NSMutableURLRequest {
    
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
    }
}
