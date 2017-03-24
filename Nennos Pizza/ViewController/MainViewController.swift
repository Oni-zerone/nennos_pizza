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
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
}
