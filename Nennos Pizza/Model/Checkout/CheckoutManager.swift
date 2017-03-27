//
//  CheckoutManager.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 27/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

struct CheckoutManager {
    
    static public let ErrorDomain = "NENNO_CHECKOUT_DOMAIN"
    
    struct Config {

        public static var scheme: String!
        public static var host: String!
        public static var basePath: String?
        
        internal static let session = {
            
            return URLSession(configuration: URLSessionConfiguration.default)
        }()
    }
    
    static func send(_ cart: Cart, success: @escaping(Bool, Error?) -> ()) {
     
        guard let url = self.prepareURL(for: "post.php") else {
            
            return success(false, NSError.invalidPath(ErrorDomain))
        }
        let request = CheckoutRequest(url: url)
        
        do  {
        
            try request.register(cart: cart)

            let task = Config.session.dataTask(with: request as URLRequest) { (responseData, response, error) in
                
                if let error = error {
                    success(false, error)
                    return
                }
                
                success(false, error)
            }
            task.resume()
        
        } catch let error {
            success(false, error)
        }
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
