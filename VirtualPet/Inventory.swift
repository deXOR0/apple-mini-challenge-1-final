//
//  Inventory.swift
//  VirtualPet
//
//  Created by Atyanta Awesa Pambharu on 10/04/22.
//

import Foundation

class Inventory: Codable {
    var foodCollection: [String:Int]
    var backgroundCollection:[String]
    var backgroundUsed: String
    
    init() {
        foodCollection = [String: Int]()
        backgroundCollection = [String]()
        backgroundUsed = "Background_Park"
    }
    
    /**
        Consume a food item from inventory

        - Parameter foodID: ID of a food item
        
        - Returns: A boolean value, true if the food item was found on the inventory and consumed, false if otherwise
    */
    func consumeFood(foodID: String) -> Bool {
        
        if var quantity = foodCollection[foodID] {
            quantity -= 1
            foodCollection[foodID] = quantity
            
            if quantity <= 0 {
                foodCollection.removeValue(forKey: foodID)
            }
            
            return true

        }

        return false
        
    }

    func storeFood (foodID: String, quantity: Int) {
        
        if let currentQuantity = foodCollection[foodID] {
            foodCollection[foodID] = currentQuantity + quantity
        }
        else {
            foodCollection[foodID] = quantity
        }
        
    }

    /**
        Use background from inventory

        - Parameter backgroundID: ID of a background item
        
        - Returns: A boolean value, true if the background item was found on the inventory and used, false if otherwise
    */
    func useBackground(backgroundID: String) -> Bool {

        if let index = backgroundCollection.firstIndex(of: backgroundID) {

            backgroundUsed = backgroundCollection[index]
            return true

        }

        return false

    }

    func storeBackground(backgroundID: String) {

        backgroundCollection.append(backgroundID)

    }
    
}
