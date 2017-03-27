//
//  IngredientDataSource.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 25/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

class PricedItemDataSource<Item: PricedItem>: BaseDataSource<Item> {
    
    var title: String?
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let priceableCell = cell as? PricedItemCell {
            
            let item = self.items[indexPath.row]
            
            priceableCell.set(name: item.name)
            priceableCell.set(price: item.price)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return self.title
        }
        
        return nil
    }
}
