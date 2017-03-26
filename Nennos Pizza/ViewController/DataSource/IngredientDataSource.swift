//
//  IngredientDataSource.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 25/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

class IngredientDataSource: BaseDataSource<Ingredient> {
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let ingredientCell = cell as? IngredientCell {
            
            let ingredient = self.items[indexPath.row]
            
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
