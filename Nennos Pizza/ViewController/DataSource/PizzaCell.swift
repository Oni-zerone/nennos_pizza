//
//  PizzaCell.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 26/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit


protocol PizzaCell {

    func set(price: Double)
    func set(name: String)
    func set(ingredients: String)
    func set(image:UIImage)
}
