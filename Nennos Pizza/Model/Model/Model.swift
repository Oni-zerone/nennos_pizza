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
    private var drinks: Array<Drink>?
    
    private var pizzaIngredients = Dictionary<Pizza, Array<Ingredient>>()
    private var pizzaPrices = Dictionary<Pizza, Double>()
    
    internal func getCachedPizzas(completion: @escaping (Array<Pizza>) -> ()) {
        
        if let pizzas = self.pizzas {
            
            completion(pizzas)
            return
        }
        
        APIManager.getPizzas(completion: { (items, error) in
            
            let pizzas = items ?? Array<Pizza>()
            if pizzas.count > 0 {
                Model.queue.sync {
                    self.pizzas = pizzas
                }
            }
            
            completion(pizzas)
        })
    }
    
    internal func getCachedIngredients(completion: @escaping (Array<Ingredient>) -> ()) {
        
        if let ingredients = self.ingredients {
            
            completion(ingredients)
            return
        }
        
        APIManager.getIngredients(completion: { (items, error) in
            
            let ingredients = items ?? Array<Ingredient>()
            if ingredients.count > 0 {
                Model.queue.sync {
                    self.ingredients = ingredients
                }
            }
            
            completion(ingredients)
        })
    }
    
    internal func getCachedDrinks(completion: @escaping (Array<Drink>) -> ()) {
        
        if let drinks = self.drinks {
            
            completion(drinks)
            return
        }
        
        APIManager.getDrinks(completion: { (items, error) in
            
            let drinks = items ?? Array<Drink>()
            
            if drinks.count > 0 {
                Model.queue.sync {
                    self.drinks = drinks
                }
            }
            completion(drinks)
        })
    }
    
    internal func  getCachedIngredients(for pizza:Pizza, completion: @escaping (Array<Ingredient>) -> ()) {
        
        if let ingredients = self.pizzaIngredients[pizza] {
            
            completion(ingredients)
            return
        }
        
        APIManager.getIngredients(for: pizza, completion: { (items, error) in
            
            let ingredients = items ?? Array<Ingredient>()
            if ingredients.count > 0 {
                Model.queue.sync {
                    self.pizzaIngredients[pizza] = ingredients
                }
            }
            
            completion(ingredients)
        })
    }
    
    internal func getCachedPrice(for pizza:Pizza, completion: @escaping (Double) -> ()) {
        
        if let price = self.pizzaPrices[pizza] {
            completion(price)
            return
        }
        
        getCachedIngredients(for: pizza) { (ingredients) in
            
            let price = self.calculatePrice(with: ingredients)
            
            completion(price)
            Model.queue.sync {
                self.pizzaPrices[pizza] = price
            }
        }
    }
    
    private func calculatePrice(with ingredients:Array<Ingredient>) -> Double {
        
        var price = Pizza.basePrice
        
        ingredients.forEach { (ingredient) in
            
            price += ingredient.price
        }
        
        return price
    }
}
