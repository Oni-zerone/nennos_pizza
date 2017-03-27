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
    @IBOutlet weak var checkoutControl: LabelControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "CART"
        
        self.setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.dataSource.items = Model.shared.cart.items
        self.checkoutControl.isEnabled = !self.dataSource.items.isEmpty
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
        
        let control = sender as? UIControl
        control?.isEnabled = false
        
        Model.shared.sendCart { (success) in
            
            if !success {
                
                return
            }
            let alert = UIAlertController(title: "Thank You!",
                                          message: "Completed successfully!",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: { (action) in
                                            
                                            _ = self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true)
        }
    }
}

extension CartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard self.dataSource.items.count > indexPath.row else {
            
            return
        }
        
        let index = indexPath.row
        
        if Model.shared.cart.removeItem(at: index) {
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.dataSource.items.remove(at: index)
            
            self.tableView.reloadSections(IndexSet(integer: 1), with: .none)
            self.tableView.endUpdates()
            self.checkoutControl.isEnabled = !self.dataSource.items.isEmpty
        }
    }
}
