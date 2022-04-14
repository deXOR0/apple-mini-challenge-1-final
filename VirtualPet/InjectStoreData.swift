//
//  InjectStoreData.swift
//  VirtualPet
//
//  Created by Atyanta Awesa Pambharu on 14/04/22.
//

import Foundation
import UIKit

class StoreData {
    var foods: [String: Food] = [String: Food]()
    var backgrounds: [String: Background] = [String: Background]()
    
    init () {
        foods["candy"] = (Food(foodID: "Candy", foodName: "Candy", foodImage: UIImage(named: "Food_Candy_stroked"), foodHealth: 10, foodPrice: 30, foodDetail: "Candy.. to make your life sweeter"))
        foods["cookie"] = (Food(foodID: "Cookie", foodName: "Cookie", foodImage: UIImage(named: "Food_Cookie_stroked"), foodHealth: 30, foodPrice: 50, foodDetail: "Contrasting flavors and texture that can satisfy your tounge"))
        foods["pizza"] = (Food(foodID: "Pizza", foodName: "Pizza", foodImage: UIImage(named: "Food_Pizza_stroked"), foodHealth: 60, foodPrice: 70, foodDetail: "Ahh Mamamiaa… delizioso pizza"))
        
        backgrounds["park"] = (Background(backgroundID: "Background_Park", backgroundName: "Background_Park", backgroundImage: UIImage(named: "Background_Underwater_v2"), backgroundDetail: "Butterflies in the sky, I can go twice as high", backgroundPrice: 0))
        backgrounds["sea"] = (Background(backgroundID: "Background_Underwater_v2", backgroundName: "Background_Underwater_v2", backgroundImage: UIImage(named: "Background_Underwater_v2"), backgroundDetail: "Blp blp blp", backgroundPrice: 150))
        backgrounds["city"] = (Background(backgroundID: "Background_City", backgroundName: "Background_City", backgroundImage: UIImage(named: "Background_City"), backgroundDetail: "Lonely in the night", backgroundPrice: 300))
        
    }
    
}
