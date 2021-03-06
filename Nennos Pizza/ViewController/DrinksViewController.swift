//
//  DrinksViewController.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 27/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

class DrinksViewController: UIViewController {

    //Model
    var dataSource: PricedItemDataSource<Drink>!
    
    //View
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "DRINKS"
        
        self.setupTableView()
        
        Model.shared.getDrinks { (drinks) in
            self.dataSource.items = drinks
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView() {
        
        self.tableView.estimatedRowHeight = 44
        let cellName = String(describing: DrinkTableViewCell.self)
        self.tableView.register(DrinkTableViewCell.self, forCellReuseIdentifier: cellName)
        
        self.dataSource = PricedItemDataSource<Drink>(with: cellName, tableView: self.tableView)
    }
}

extension DrinksViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let index = indexPath.row
        guard self.dataSource.items.count > index else {
            
            return
        }
        
        Model.shared.cart.insert(item: self.dataSource.items[index])
        self.tableView.deselectRow(at: indexPath, animated: false)
    }
}
