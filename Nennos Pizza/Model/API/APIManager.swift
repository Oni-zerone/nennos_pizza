//
//  APIManager.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 24/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

struct APIManager {
    
    static public let ErrorDomain = "NENNO_API_DOMAIN"
    
    static fileprivate func responseCheck(_ completion:@escaping (Dictionary<String, Any>?, Error?) -> Void) -> (Data?, URLResponse?, Error?) -> Void {
        
        return { (_ responseData: Data?, _ response: URLResponse?, _ error: Error?) in
            
            guard let data = responseData, error == nil else {
                
                return completion(nil, error)
            }
            
            do {
                
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                
                guard let dictionary = jsonObject as? Dictionary<String, Any> else {
                    return completion(nil, NSError(domain: APIManager.ErrorDomain,
                                                   code: 500,
                                                   userInfo: [NSLocalizedDescriptionKey : "invalid response"]))
                }
                
                return completion(dictionary, nil)
                
            } catch let jsonError {
                
                return completion(nil, jsonError)
            }
        }
    }
    
    static fileprivate func URLForResource(resourcePath: String) -> URL? {
        
        let fullPath = "\(APIConfig.scheme!)://\(APIConfig.host!)/\(APIConfig.basePath)/\(resourcePath)"
        
        return URL(string:fullPath)
    }
    
}