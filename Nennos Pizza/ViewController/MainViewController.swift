//
//  MainViewController.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 24/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //Model
    fileprivate var pizzas: Array<Pizza> = [] {
        
        didSet {
            self.tableView.reloadData()
        }
    }
    
    //Views
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Model.shared.getPizzas { (pizzas) in
            self.pizzas = pizzas
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        return UITableViewCell()
    }
    
}
