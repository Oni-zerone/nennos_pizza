//
//  ModelError.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 27/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

extension NSError {
    
    static internal func invalidPath(_ domain:String) -> NSError {
        
        return NSError(domain: domain,
                       code: 500,
                       userInfo: [NSLocalizedDescriptionKey : "invalid path"])
    }
    
    static internal func invalidContent(_ domain:String) -> NSError {
        
        return NSError(domain: domain,
                       code: 500,
                       userInfo: [NSLocalizedDescriptionKey : "invalid content"])
    }
    
    static internal func invalidResponse(_ domain:String) -> NSError {
        
        return NSError(domain: domain,
                       code: 500,
                       userInfo: [NSLocalizedDescriptionKey : "invalid response"])
    }
}
