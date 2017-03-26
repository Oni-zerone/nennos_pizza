//
//  CartViewController.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 26/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    //Model
    var dataSource: CartDatasource!
    
    //View
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkoutControl: PriceControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CART"
        
        self.setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.dataSource.items = Model.shared.cart.items
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView() {
        
        self.tableView.estimatedRowHeight = 44
        let cellName = String(describing: CartTableViewCell.self)
        self.tableView.register(CartTableViewCell.self, forCellReuseIdentifier: cellName)

        self.dataSource = CartDatasource(with: cellName, tableView: self.tableView)
    }
    
    @IBAction func checkoutAction(_ sender: Any) {
        
    }
}

extension CartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
}
