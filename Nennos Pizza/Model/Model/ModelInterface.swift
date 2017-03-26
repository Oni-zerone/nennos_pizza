//
//  ModelInterface.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 26/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

fileprivate typealias ModelInterface = Model

extension ModelInterface {
    
    func getPizzas(completion: @escaping (Array<Pizza>) -> ()) {
        
        Model.queue.async {
            
            self.getCachedPizzas { (ingredients) in
                
                DispatchQueue.main.async {
                    completion(ingredients)
                }
            }
        }
    }
    
    func getIngredients(completion: @escaping (Array<Ingredient>) -> ()) {
        
        Model.queue.async {
            
            self.getCachedIngredients(completion: { (ingredients) in
                
                DispatchQueue.main.async {
                    completion(ingredients)
                }
            })
        }
    }
    
    func getIngredients(for pizza:Pizza, completion: @escaping (Array<Ingredient>) -> ()) {
        
        Model.queue.async {
            
            self.getCachedIngredients(for: pizza) { (ingredients) in
                
                DispatchQueue.main.async {
                    completion(ingredients)
                }
            }
        }
    }
    
    func getPrice(for pizza: Pizza, completion: @escaping(Double) -> ()) {
        
        Model.queue.async {
            
            self.getCachedPrice(for: pizza, completion: { (ingredients) in
                
                DispatchQueue.main.async {
                    completion(ingredients)
                }
            })
        }
    }
    
    func getDrinks(completion: @escaping (Array<Drink>) -> ()) {
        
        Model.queue.async {
            
            self.getCachedDrinks(completion: { (drinks) in
                DispatchQueue.main.async {
                    completion(drinks)
                }
            })
        }
    }
}
