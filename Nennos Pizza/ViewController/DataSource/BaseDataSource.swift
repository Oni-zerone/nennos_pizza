//
//  BaseDataSource.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 26/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

class BaseDataSource<Item>: NSObject, UITableViewDataSource {

    //Model
    var items: Array<Item> = [] {
        
        willSet {
            self.tableView?.beginUpdates()
            self.tableView?.deleteSections(IndexSet(integer: 0), with: .none)
        }
        
        didSet {
            self.tableView?.insertSections(IndexSet(integer: 0), with: .none)
            self.tableView?.endUpdates()
        }
    }
    
    let cellIdentifier: String
    
    //View
    private weak var tableView: UITableView?
    
    required init(with identifier: String, tableView: UITableView) {
        
        self.cellIdentifier = identifier
        self.tableView = tableView
        
        super.init()
        tableView.dataSource = self
    }
    
    //MARK: UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
    }
}
