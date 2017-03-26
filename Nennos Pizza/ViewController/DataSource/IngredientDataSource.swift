//
//  IngredientDataSource.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 25/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

protocol IngredientCell {
    
    func set(name: String)
    func set(price: Double)
}

class IngredientDataSource: NSObject, UITableViewDataSource {
    
    //Model
    var ingredients: Array<Ingredient> = [] {
        
        willSet {
            self.tableView?.beginUpdates()
            self.tableView?.deleteSections(IndexSet(integer: 0), with: .none)
        }
        
        didSet {
            self.tableView?.insertSections(IndexSet(integer: 0), with: .none)
            self.tableView?.endUpdates()
        }
    }

    let cellIdentifier: String
    
    //View
    private weak var tableView: UITableView?
    
    required init(with identifier: String, tableView: UITableView) {
        
        self.cellIdentifier = identifier
        self.tableView = tableView
        
        super.init()
        tableView.dataSource = self
    }
    
    //MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        if let ingredientCell = cell as? IngredientCell {
            
            let ingredient = self.ingredients[indexPath.row]
            
            ingredientCell.set(name: ingredient.name)
            ingredientCell.set(price: ingredient.price)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Ingredients"
        }
        
        return nil
    }
}
