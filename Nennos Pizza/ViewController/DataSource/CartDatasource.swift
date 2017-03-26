//
//  CartDatasource.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 26/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

class CartDatasource: BaseDataSource<ShippableItem> {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return super.tableView(tableView, numberOfRowsInSection: section)
        
        case 1:
            return 1
            
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        guard let cartCell = cell as? CartCell  else {
            return cell
        }
        
        if indexPath.section == 0 {

            let item = self.items[indexPath.row]
            tableView.prepare(cartCell, with: item, at: indexPath)
            
            cell.isUserInteractionEnabled = true
            return cell
        }
        
        
        cartCell.set(name: "TOTAL")
        tableView.setTotal(for: Model.shared.cart, at: indexPath)
        
        cell.isUserInteractionEnabled = false
        return cell
    }
}

fileprivate extension UITableView {

    func prepare(_ cell:CartCell, with item: ShippableItem , at indexPath: IndexPath) {
        
        cell.set(name: item.name)
        self.setPrice(for: item, at: indexPath)
    }
    
    func setPrice(for item: ShippableItem, at indexPath: IndexPath) {
        
        item.getPrice { (price) in

            self.set(price: price, at: indexPath)
        }
    }
    
    func setTotal(for cart: Cart, at indexPath: IndexPath) {
        
        cart.getPrice { (price) in

            self.set(price: price, at: indexPath)
        }
    }
    
    func set(price: Double, at indexPath: IndexPath) {
        
        guard let cell = self.cellForRow(at: indexPath) as? CartCell else {
            
            return
        }
        
        cell.set(price: price)
        self.setNeedsUpdateConstraints()
    }
}

