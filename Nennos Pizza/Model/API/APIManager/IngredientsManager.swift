//
//  APIManagerIngredients.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 24/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

fileprivate typealias IngredientsManager = APIManager

extension IngredientsManager {
    
    static func getIngredients(session: URLSession = Config.session, completion: @escaping(Array<Ingredient>?, Error?) -> ()) {
        
        guard let URL = APIManager.URLForResource(resourcePath: "EkTFDCdsG") else {
            
            return completion(nil, NSError.invalidPath(ErrorDomain))
        }
        
        let task = session.dataTask(with: APIRequest(url: URL) as URLRequest, completionHandler: APIManager.responseArrayCheck({ (response, error) in
            
            if let e = error {
                
                return completion(nil, e)
            }
            
            guard let items = response as? Array<Dictionary<String, Any>> else {
                
                return completion(nil, NSError.invalidContent(ErrorDomain))
            }
            
            let ingredients = items.flatMap({ (item) -> Ingredient? in
                return Ingredient(resource: item)
            })
            
            completion(ingredients, nil)
        }))
        
        task.resume()
    }
    
    static func getIngredients(for pizza:Pizza, completion: @escaping(Array<Ingredient>?, Error?) -> ()) {
        
        APIManager.getIngredients { (ingredients, error) in

            if let e = error {
                return completion(nil, e)
            }
            
            let pizzaIngredients = ingredients?.filter({ (ingredient) -> Bool in
                
                return pizza.ingredientIds.index(of: ingredient.id) != nil
            })
            return completion(pizzaIngredients, nil)
        }
    }
}
