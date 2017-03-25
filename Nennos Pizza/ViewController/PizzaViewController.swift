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
    var ingredientDataSource: IngredientDataSource!
    
    var pizza: Pizza? {
        
        didSet {
            
            self.title = pizza?.name
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
            
            self.ingredientDataSource.ingredients = ingredients
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupTableView() {
        
        self.tableView.estimatedRowHeight = 178
        let cellName = String(describing: IngredientTableViewCell.self)
        
        self.tableView.register(UINib(nibName: cellName , bundle: Bundle.main), forCellReuseIdentifier: cellName)
        self.ingredientDataSource = IngredientDataSource(with: cellName, tableView: self.tableView)
    }
}
