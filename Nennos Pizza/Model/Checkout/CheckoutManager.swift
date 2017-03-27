//
//  CheckoutManager.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 27/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

struct CheckoutManager {
    
    struct Config {

        public static var scheme: String!
        public static var host: String!
        public static var basePath: String?
        
        internal static let session = {
            
            return URLSession(configuration: URLSessionConfiguration.default)
        }()
    }
    
    static func send(_ cart: Cart, success: @escaping(Bool, Error?) -> ()) {
        
        let task = Config.session.dataTask(with: URL(string:"http://www.google.com")!) { (responseData, response, error) in
            
            if let error = error {
                success(false, error)
                return
            }
            
            success(false, error)
        }
        task.resume()
    }
    
    static func prepareURL(for resource: String) -> URL? {
        
        var fullUrl = "\(Config.scheme!)://\(Config.host!)/"
        
        if let basePath = Config.basePath {
            fullUrl += "\(basePath)/"
        }
        
        fullUrl += resource
        
        return URL(string: fullUrl)
    }
}
