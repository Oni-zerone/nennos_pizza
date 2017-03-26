//
//  CartDatasource.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 26/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

class CartDatasource: BaseDataSource<ShippableItem> {

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let cartCell = cell as? CartCell {
            
            let item = self.items[indexPath.row]

            cartCell.set(name: item.name)
            tableView.setPrice(for: item, at: indexPath)
        }
        
        return cell
    }
}

fileprivate extension UITableView {
    
    func setPrice(for item: ShippableItem, at indexPath: IndexPath) {
        
        item.getPrice { (price) in
            guard let cell = self.cellForRow(at: indexPath) as? CartCell else {
                
                return
            }
            
            cell.set(price: price)
            self.setNeedsUpdateConstraints()
        }
    }
    
}
