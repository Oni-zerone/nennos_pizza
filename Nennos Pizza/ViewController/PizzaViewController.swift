//
//  PizzaViewController.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 25/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

class PizzaViewController: UIViewController {

    //Model
    var ingredientDataSource: IngredientDataSource?
    
    var pizza: Pizza? {
        
        didSet {
            
            guard let pizza = self.pizza else {
                return
            }
            
            self.title = pizza.name
            self.selectIngredients()
        }
    }
    
    
    //View
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var pizzaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupTableView()
        
        Model.shared.getIngredients { (ingredients) in
            
            self.ingredientDataSource?.ingredients = ingredients
            self.selectIngredients()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupTableView() {
        
        self.tableView.estimatedRowHeight = 44
        
        let cellName = String(describing: IngredientTableViewCell.self)
        self.tableView.register(UINib(nibName: cellName , bundle: Bundle.main),
                                forCellReuseIdentifier: cellName)
        
        self.ingredientDataSource = IngredientDataSource(with: cellName, tableView: self.tableView)
    }
    
    func selectIngredients() {
        
        guard let pizza = self.pizza,
         let ingredients = self.ingredientDataSource?.ingredients else {
            return
        }
        
        pizza.ingredientIds.forEach({ (ingredientId) in
            
            guard let index = ingredients.index(where: { (ingredient) -> Bool in
                return ingredient.id == ingredientId
            }) else {
                return
            }
            
            self.tableView.selectRow(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: UITableViewScrollPosition.none)
        })
    }
}

extension PizzaViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        
        if let textLabel = header.textLabel {
            textLabel.font = UIFont.titleFont
            textLabel.textColor = UIColor.textColor
        }
        
        header.backgroundView?.backgroundColor = UIColor.white
    }
    
}
