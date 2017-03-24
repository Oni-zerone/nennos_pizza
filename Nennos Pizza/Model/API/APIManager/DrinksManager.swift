//
//  DrinksManager.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 24/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

fileprivate typealias DrinksManager = APIManager

extension DrinksManager {

    static func getDrinks(session: URLSession = APIConfig.session, completion: @escaping(Array<Drink>?, Error?) -> ()) {
        
        guard let URL = APIManager.URLForResource(resourcePath: "N1mnOA_oz") else {
            
            return completion(nil, NSError.invalidPath())
        }
        
        let task = session.dataTask(with: APIRequest(url: URL) as URLRequest, completionHandler: APIManager.responseArrayCheck({ (response, error) in
            
            if let e = error {
                
                return completion(nil, e)
            }
            
            guard let items = response as? Array<Dictionary<String, Any>> else {
                
                return completion(nil, NSError.invalidContent())
            }
            
            let ingredients = items.flatMap({ (item) -> Drink? in
                return Drink(resource: item)
            })
            
            completion(ingredients, nil)
        }))
        task.resume()
    }
}
