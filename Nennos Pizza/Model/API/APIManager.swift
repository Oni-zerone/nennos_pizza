//
//  APIManager.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 24/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

struct APIManager {
    
    struct Config {
        
        //MARK: URL parameters
        
        public static var scheme: String!
        public static var host: String!
        public static var basePath: String!
        
        static let session = {
            
            return URLSession(configuration: URLSessionConfiguration.default)
        }()
    }

    
    static public let ErrorDomain = "NENNO_API_DOMAIN"
    
    static internal func responseDictionaryCheck(_ completion:@escaping (Dictionary<String, Any>?, Error?) -> Void) -> (Data?, URLResponse?, Error?) -> Void {
        
        return { (_ responseData: Data?, _ response: URLResponse?, _ error: Error?) in
            
            guard let data = responseData, error == nil else {
                
                return completion(nil, error)
            }
            
            do {
                
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                
                guard let dictionary = jsonObject as? Dictionary<String, Any> else {
                    return completion(nil, NSError.invalidResponse(ErrorDomain))
                }
                
                return completion(dictionary, nil)
                
            } catch let jsonError {
                
                return completion(nil, jsonError)
            }
        }
    }
    
    static internal func responseArrayCheck(_ completion:@escaping (Array<Any>?, Error?) -> Void) -> (Data?, URLResponse?, Error?) -> Void {

        return { (_ responseData: Data?, _ response: URLResponse?, _ error: Error?) in
            
            guard let data = responseData, error == nil else {
                
                return completion(nil, error)
            }
            
            do {
                
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                
                guard let array = jsonObject as? Array<Any> else {
                    return completion(nil, NSError.invalidResponse(ErrorDomain))
                }
                
                return completion(array, nil)
                
            } catch let jsonError {
                
                return completion(nil, jsonError)
            }
        }
    }
    
    static internal func URLForResource(resourcePath: String) -> URL? {
        
        let fullPath = "\(Config.scheme!)://\(Config.host!)/\(Config.basePath!)/\(resourcePath)"
        return URL(string:fullPath)
    }
}
