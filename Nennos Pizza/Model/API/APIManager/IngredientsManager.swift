//
//  APIManagerIngredients.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 24/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

fileprivate typealias IngredientsManager = APIManager

extension APIManager {
    
    static func getIngredients(session: URLSession = APIConfig.session, completion: @escaping(Array<Ingredient>?, Error?) -> ()) {
        
        guard let URL = APIManager.URLForResource(resourcePath: "EkTFDCdsG") else {
            
            return completion(nil, NSError.invalidPath())
        }
        
        let task = session.dataTask(with: APIRequest(url: URL) as URLRequest, completionHandler: APIManager.responseArrayCheck({ (response, error) in
            
            if let e = error {
                
                return completion(nil, e)
            }
            
            guard let items = response as? Array<Dictionary<String, Any>> else {
                
                return completion(nil, NSError.invalidContent())
            }
            
            let ingredients = items.flatMap({ (item) -> Ingredient? in
                return Ingredient(resource: item)
            })
            
            completion(ingredients, nil)
        }))
        
        task.resume()
    }
}
