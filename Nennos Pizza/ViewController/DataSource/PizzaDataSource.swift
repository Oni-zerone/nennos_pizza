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

protocol PizzaCell {
    
    func set(price: Double)
    func set(name: String)
    func set(ingredients: String)
    func set(image:UIImage)
}

class PizzaDataSource : NSObject, UITableViewDataSource {
    
    //Model
    var cellIdentifier: String
    var pizzas: Array<Pizza> = [] {
        
        willSet {
            self.tableView?.beginUpdates()
            self.tableView?.deleteSections(IndexSet(integer: 0), with: .none)
        }
        
        didSet {
            self.tableView?.insertSections(IndexSet(integer: 0), with: .none)
            self.tableView?.endUpdates()
        }
    }
    
    //View
    private weak var tableView: UITableView?
    
    required init(with identifier: String, tableView: UITableView) {
        
        self.cellIdentifier = identifier
        self.tableView = tableView
        
        super.init()
        tableView.dataSource = self
    }
    
    //MARK: TableViewDatasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pizzas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)

        let pizza = pizzas[indexPath.row]
        
        if let pizzaCell = cell as? PizzaCell {

            pizzaCell.set(name: pizza.name)
            tableView.setIngredients(for: pizza, at: indexPath)
            tableView.setImage(for: pizza, at: indexPath)
            tableView.setPrice(for: pizza, at: indexPath)
        }
        return cell
    }
    
}

fileprivate typealias PizzaTable = UITableView

extension PizzaTable {
    
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
        }
    }
    
    func setPrice(for pizza: Pizza, at indexPath: IndexPath) {
        
        Model.shared.getPrice(for: pizza) { (pizzaPrice) in
            
            guard let cell = self.cellForRow(at: indexPath) as? PizzaCell else {
                
                return
            }
            
            cell.set(price: pizzaPrice)
        }
    }
}
