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
    
    func getCachedPizzas(completion: @escaping (Array<Pizza>) -> ()) {
    
        if let pizzas = self.pizzas {
            
                completion(pizzas)
            return
        }
        
            APIManager.getPizzas(completion: { (items, error) in
                
                let pizzas = items ?? Array<Pizza>()
                if pizzas.count > 0 {
                    self.pizzas = pizzas
                }
                
                completion(pizzas)
            })
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
    
    fileprivate func  getCachedIngredients(for pizza:Pizza, completion: @escaping (Array<Ingredient>) -> ()) {
        
        if let ingredients = self.pizzaIngredients[pizza] {
            
            completion(ingredients)
            return
        }
        
        APIManager.getIngredients(for: pizza, completion: { (items, error) in
            
            let ingredients = items ?? Array<Ingredient>()
            if ingredients.count > 0 {
                self.pizzaIngredients[pizza] = ingredients
            }
            
            completion(ingredients)
        })
    }

    
    fileprivate func getCachedPrice(for pizza:Pizza, completion: @escaping (Double) -> ()) {
        
        if let price = self.pizzaPrices[pizza] {
            completion(price)
            return
        }
        
        getCachedIngredients(for: pizza) { (ingredients) in
            
            let price = self.calculatePrice(with: ingredients)
            
            completion(price)
            self.pizzaPrices[pizza] = price
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
}
