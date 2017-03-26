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

    struct segue {

        static let showPizza = "showPizza"
    }
    
    
    //Model
    var pizzaDataSource: PizzaDataSource!
    
    //Views
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Nenno's Pizza"
        
        self.setupTableView()
        
        Model.shared.getPizzas { (pizzas) in
            self.pizzaDataSource.items = pizzas
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        
        if let selectedRow = self.tableView.indexPathForSelectedRow {
            
            self.tableView.deselectRow(at: selectedRow, animated: animated)
        }

        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        self.pizzaDataSource.items = Array<Pizza>()
    }
    
    func setupTableView() {
        
        self.tableView.estimatedRowHeight = 178
        let cellName = String(describing: MainTableViewCell.self)
        
        self.tableView.register(UINib(nibName: cellName , bundle: Bundle.main), forCellReuseIdentifier: cellName)
        self.pizzaDataSource = PizzaDataSource(with: cellName, tableView: self.tableView)
        self.pizzaDataSource.cellDelegate = self
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
            
        case MainViewController.segue.showPizza:
            
            guard let destination = segue.destination as? PizzaViewController,
                let pizza = sender as? Pizza else {
                
                    return
            }
            
            destination.pizza = pizza
            break
            
        default:
            
            break
        }
        
    }
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard self.pizzaDataSource.items.count > indexPath.row else {
            return
        }
        
        let pizza = self.pizzaDataSource.items[indexPath.row]
        self.performSegue(withIdentifier: MainViewController.segue.showPizza, sender: pizza)
    }
    
}

extension MainViewController: MainTableViewCellDelegate {
    
    func didPressedBuy(for cell: MainTableViewCell) {
        
        guard let indexPath = self.tableView.indexPath(for: cell),
              self.pizzaDataSource.items.count > indexPath.row  else {
            return
        }
        
        Model.shared.cart.insert(pizza: self.pizzaDataSource.items[indexPath.row])
    }
    
}
