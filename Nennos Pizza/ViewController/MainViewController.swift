//
//  MainViewController.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 24/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit
import AlamofireImage

class MainViewController: UIViewController {

    //Model
    fileprivate var pizzas: Array<Pizza> = [] {
        
        willSet {
            self.tableView.beginUpdates()
            self.tableView.deleteSections(IndexSet(integer: 0), with: .none)
        }
        
        didSet {
            self.tableView.insertSections(IndexSet(integer: 0), with: .none)
            self.tableView.endUpdates()
        }
    }
    
    //Views
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Nenno's Pizza"
        
        self.setupTableView()
        
        Model.shared.getPizzas { (pizzas) in
            self.pizzas = pizzas
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        self.pizzas = Array<Pizza>()
    }
    
    func setupTableView() {
        
        self.tableView.estimatedRowHeight = 178
        self.tableView.register(UINib(nibName: String(describing: MainTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: MainTableViewCell.self))
    }
    
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pizzas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MainTableViewCell.self), for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        
        let pizza = self.pizzas[indexPath.row]
        cell.pizzaLabel.text = pizza.name

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

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
}
