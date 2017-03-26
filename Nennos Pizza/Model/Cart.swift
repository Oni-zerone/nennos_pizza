//
//  Cart.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 26/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import Foundation

struct Cart {
    
    internal static let queue = DispatchQueue(label: "it.studiout.nenno.modelQueue")

    var items = Array<ShippableItem>()
    
    struct Notifications {
        
        static let didAddItem = Notification.Name("it.studiout.NennosPizza.Cart.didAddItem")
    }
    
    func getPrice(completion: @escaping (Double) -> ()) {
        
        var totalPrice: Double = 0
        let dispatchGroup = DispatchGroup()
        
        Cart.queue.async {
            self.items.forEach({ (item) in
                
                dispatchGroup.enter()
                item.getPrice(completion: { (price) in
                    
                    totalPrice += price
                    dispatchGroup.leave()
                })
            })

            dispatchGroup.wait()
            DispatchQueue.main.async {
                
                completion(totalPrice)
            }
        }
    }
}

fileprivate typealias MutableCart = Cart

extension MutableCart {
    
    mutating func insert(item: ShippableItem) {
        
        self.items.append(item)

        DispatchQueue.main.async {
            NotificationCenter.default.post(name: Cart.Notifications.didAddItem, object: nil)
        }
    }
    
    mutating func removeItem(at index: Int) -> Bool {
        
        guard self.items.count > index else {
            return false
        }
        
        self.items.remove(at: index)
        return true
    }
}
