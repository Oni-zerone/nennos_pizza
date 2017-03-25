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
    var pizzaDataSource: PizzaDataSource?
    
    //Views
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Nenno's Pizza"
        
        self.setupTableView()
        
        Model.shared.getPizzas { (pizzas) in
            self.pizzaDataSource?.pizzas = pizzas
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        self.pizzaDataSource?.pizzas = Array<Pizza>()
    }
    
    func setupTableView() {
        
        self.tableView.estimatedRowHeight = 178
        let cellName = String(describing: MainTableViewCell.self)
        
        self.tableView.register(UINib(nibName: cellName , bundle: Bundle.main), forCellReuseIdentifier: cellName)
        self.pizzaDataSource = PizzaDataSource(with: cellName, tableView: self.tableView)
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
}
