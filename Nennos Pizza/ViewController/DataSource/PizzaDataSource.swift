//
//  PizzaDataSource.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 25/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

import Alamofire
import AlamofireImage

class PizzaDataSource : BaseDataSource<Pizza> {
    
    //Model
    weak var cellDelegate: AnyObject?
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)

        let pizza = items[indexPath.row]
        
        if let pizzaCell = cell as? PizzaCell {

            pizzaCell.set(name: pizza.name)
            pizzaCell.set(delegate: self.cellDelegate)
            tableView.setIngredients(for: pizza, at: indexPath)
            tableView.setImage(for: pizza, at: indexPath)
            tableView.setPrice(for: pizza, at: indexPath)
        }
        return cell
    }
}

fileprivate typealias PizzaTable = UITableView

fileprivate extension PizzaTable {
    
    func setIngredients(for pizza:Pizza, at indexPath:IndexPath) {
        
        Model.shared.getIngredients(for: pizza) { (ingredients) in
            
            var ingredientsString = String()
            ingredients.forEach({ (ingredient) in
                if(ingredientsString.characters.count > 0) {
                    ingredientsString += ", "
                }
                ingredientsString += ingredient.name
            })
            if(ingredientsString.characters.count > 0) {
                ingredientsString += "."
            }
            
            guard let cell = self.cellForRow(at: indexPath) as? PizzaCell else {
                return
            }
            cell.set(ingredients: ingredientsString)
            self.setNeedsUpdateConstraints()
        }
    }
    
    func setImage(for pizza: Pizza, at indexPath: IndexPath) {
        
        guard let imageUrl = pizza.imageUrl else {
            
            return
        }
        
        Alamofire.request(imageUrl).responseImage { (responseImage) in
            
            guard let image = responseImage.value,
                let cell = self.cellForRow(at: indexPath) as? PizzaCell else {
                
                    return
            }
            
            cell.set(image: image)
            self.setNeedsUpdateConstraints()
        }
    }
    
    func setPrice(for pizza: Pizza, at indexPath: IndexPath) {
        
        Model.shared.getPrice(for: pizza) { (pizzaPrice) in
            
            guard let cell = self.cellForRow(at: indexPath) as? PizzaCell else {
                
                return
            }
            
            cell.set(price: pizzaPrice)
            self.setNeedsUpdateConstraints()
        }
    }
}
