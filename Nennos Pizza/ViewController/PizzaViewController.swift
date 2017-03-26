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
    var ingredientDataSource: IngredientDataSource?
    var pizza: Pizza? {
        
        didSet {
            if oldValue != nil {
                self.setPrice(for: pizza!)
            }
        }
    }
    
    //View
    weak var header: PizzaHeader?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addToCartButton: BigPriceControl!
    
    @IBOutlet weak var pizzaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
        guard let pizza = self.pizza else {
            return
        }
        
        self.title = pizza.name
        self.setupTableView()
        self.setupHeader()

        //Load contents
        Model.shared.getIngredients { (ingredients) in
            
            self.ingredientDataSource?.ingredients = ingredients
            self.selectIngredients()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupTableView() {
        
        self.tableView.estimatedRowHeight = 44
        
        let cellName = String(describing: IngredientTableViewCell.self)
        self.tableView.register(UINib(nibName: cellName , bundle: Bundle.main),
                                forCellReuseIdentifier: cellName)
        
        self.ingredientDataSource = IngredientDataSource(with: cellName, tableView: self.tableView)
    }
    
    func setupHeader() {
        
        let header = PizzaHeader(frame: CGRect.zero)
        header.backgroundImageView.image = #imageLiteral(resourceName: "Backgound")
        header.insert(in: self.tableView)
        self.header = header
        
        self.setHeaderImage()
    }
    
    func setHeaderImage() {
        
        guard let header = self.header,
            let pizzaUrl = self.pizza?.imageUrl,
            let imageURL = URL(string:pizzaUrl) else {
            return
        }
        
        header.pizzaImageView.af_setImage(withURL: imageURL)
    }
    
    func selectIngredients() {
        
        guard let pizza = self.pizza,
         let ingredients = self.ingredientDataSource?.ingredients else {
            return
        }
        
        pizza.ingredientIds.forEach({ (ingredientId) in
            
            guard let index = ingredients.index(where: { (ingredient) -> Bool in
                return ingredient.id == ingredientId
            }) else {
                return
            }
            
            self.tableView.selectRow(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: UITableViewScrollPosition.none)
        })
        
        self.setPrice(for: pizza)
    }
    
    func setPrice(for pizza:Pizza) {
        
        
        Model.shared.getPrice(for: pizza) { (price) in
            
            self.addToCartButton.set(price: price)
        }
    }
    
    @IBAction func addToCartAction(_ sender: Any) {
        
        guard let pizza = self.pizza else {
            
            return
        }
        
        Model.shared.cart.insert(pizza: pizza)
    }
}

extension PizzaViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }

        header.backgroundView?.backgroundColor = UIColor.white
        
        guard let textLabel = header.textLabel else {
            return
        }
        
        textLabel.font = UIFont.titleFont
        textLabel.textColor = UIColor.textColor
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let dataSource = self.ingredientDataSource,
            dataSource.ingredients.count > indexPath.row else {
                return
        }
        
        let ingredient = dataSource.ingredients[indexPath.row]
        self.pizza?.add(ingredient: ingredient)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        guard let dataSource = self.ingredientDataSource,
            dataSource.ingredients.count > indexPath.row else {
                return
        }
        
        let ingredient = dataSource.ingredients[indexPath.row]
        self.pizza?.remove(ingredient: ingredient)
    }
}
