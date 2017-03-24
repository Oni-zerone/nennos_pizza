//
//  Model.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 24/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

class Model: NSObject {

    static let queue = DispatchQueue(label: "it.studiout.nenno.modelQueue", attributes: .concurrent)

    static var shared = {
        
        return Model()
    }()

    private var ingredients: Array<Ingredient>?
    private var pizzas: Array<Pizza>?
    private var pizzaIngredients = Dictionary<Pizza, Array<Ingredient>>()
    private var drinks: Array<Drink>?
    
    func getDrinks(completion: @escaping (Array<Drink>) -> ()) {
        
        if let drinks = self.drinks {
            DispatchQueue.main.async {
                completion(drinks)
            }
            return
        }
        
        Model.queue.async {
            
            APIManager.getDrinks(completion: { (items, error) in
                
                let drinks = items ?? Array<Drink>()
                
                if drinks.count > 0 {
                    self.drinks = drinks
                }
                DispatchQueue.main.async {
                    completion(drinks)
                }
            })
        }
    }
    
    func getPizzas(completion: @escaping (Array<Pizza>) -> ()) {
    
        if let pizzas = self.pizzas {
            
            DispatchQueue.main.async {
                completion(pizzas)
            }
            return
        }
        
        Model.queue.async {

            APIManager.getPizzas(completion: { (items, error) in
                
                let pizzas = items ?? Array<Pizza>()
                if pizzas.count > 0 {
                    self.pizzas = pizzas
                }
                
                DispatchQueue.main.async {
                    completion(pizzas)
                }
            })
        }
    }
    
    func getIngredients(completion: @escaping (Array<Ingredient>) -> ()) {
        
        if let ingredients = self.ingredients {
            
            DispatchQueue.main.async {
                completion(ingredients)
            }
            return
        }
        
        Model.queue.async {
            
            APIManager.getIngredients(completion: { (items, error) in
                
                let ingredients = items ?? Array<Ingredient>()
                if ingredients.count > 0 {
                    self.ingredients = ingredients
                }
                
                DispatchQueue.main.async {
                    completion(ingredients)
                }
            })
        }
    }
    
    func getIngredients(for pizza:Pizza, completion: @escaping (Array<Ingredient>) -> ()) {
        
        
        if let ingredients = self.pizzaIngredients[pizza] {
            
            DispatchQueue.main.async {
                completion(ingredients)
            }
            return
        }
        
        Model.queue.async {
            
            APIManager.getIngredients(for: pizza, completion: { (items, error) in
              
                let ingredients = items ?? Array<Ingredient>()
                if ingredients.count > 0 {
                    self.pizzaIngredients[pizza] = ingredients
                }
                
                DispatchQueue.main.async {
                    completion(ingredients)
                }
            })
        }
    }
}
