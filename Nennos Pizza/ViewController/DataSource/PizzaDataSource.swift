//
//  PizzaDataSource.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 25/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

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
    
    required init(with identifier: String) {
        
        self.cellIdentifier = identifier
        super.init()
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
        
        if pizzas.count <= indexPath.row {
            return cell
        }
        
        return self.prepare(cell, with: pizzas[indexPath.row])
    }
    
    private func prepare(_ cell: UITableViewCell, with pizza:Pizza) -> UITableViewCell {
        
        
        guard let pizzaCell = cell as? PizzaCell else {
            return cell
        }
        
        if let imagePath = pizza.imageUrl,
            let URL = URL(string: imagePath) {
            
            cell.pizzaImageView.af_setImage(withURL: URL)
        }
        
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
            
            guard let cell = tableView.cellForRow(at: indexPath) as? MainTableViewCell else {
                return
            }
            
            cell.ingredientsLabel.text = ingredientsString;
        }
        
        return cell
    }
}



protocol PizzaCell {
    
    var pizzaNameLabel: UILabel? { get }
    var ingredientsLabel: UILabel? { get }
    var pizzaImageView: UIImageView? { get }
    
}
