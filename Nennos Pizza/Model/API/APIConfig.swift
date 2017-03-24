//
//  APIConfig.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 24/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

struct APIConfig {
    
    //MARK: URL parameters
    
    public static var scheme: String!
    public static var host: String!
    public static var basePath: String!
    
    static let session = {
        
        return URLSession(configuration: URLSessionConfiguration.default)
    }()
}
