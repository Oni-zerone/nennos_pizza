//
//  PizzasManager.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 24/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

fileprivate typealias PizzasManager = APIManager

extension PizzasManager {

    static func getPizzas(session: URLSession = APIConfig.session, completion: @escaping(Array<Pizza>?, Error?) -> ()) {
        
        guard let URL = APIManager.URLForResource(resourcePath: "NybelGcjz") else {
            
            return completion(nil, NSError.invalidPath(ErrorDomain))
        }
        
        let task = session.dataTask(with: APIRequest(url: URL) as URLRequest, completionHandler: APIManager.responseDictionaryCheck({ (response, error) in
            
            if let e = error {
                
                return completion(nil, e)
            }

            guard let resources = response else {
                
                return completion(nil, NSError.invalidContent(ErrorDomain))
            }
            
            guard let basePrice = resources["basePrice"] as? Double else {
                
                return completion(nil, NSError(domain: APIManager.ErrorDomain,
                                               code: 500,
                                               userInfo: [NSLocalizedDescriptionKey : "invalid basePrice"]))
            }
            Pizza.basePrice = basePrice
            
            guard let items = resources["pizzas"] as? Array<Dictionary<String, Any>>  else {
                
                return completion(nil, NSError.invalidContent(ErrorDomain))
            }
            
            let pizzas = items.flatMap({ (item) -> Pizza? in
                return Pizza(resource: item)
            })
            
            completion(pizzas, nil)
        }))
        task.resume()
    }
}
