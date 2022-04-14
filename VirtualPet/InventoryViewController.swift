//
//  InventoryViewController.swift
//  VirtualPet
//
//  Created by Sherary Apriliana on 14/04/22.
//

import UIKit

class InventoryViewController: UIViewController {

    var user: User = User()
    var candyCount = 0
    var cookieCount = 0
    var pizzaCount = 0
    var parkText = "Locked"
    var seaText = "Locked"
    var cityText = "Locked"
    let storeData = StoreData()
    
    @IBOutlet weak var cityStatus: UILabel!
    @IBOutlet weak var seaStatus: UILabel!
    @IBOutlet weak var parkStatus: UILabel!
    @IBOutlet weak var pizzaQty: UILabel!
    @IBOutlet weak var cookieQty: UILabel!
    @IBOutlet weak var candyQty: UILabel!
    @IBOutlet weak var money: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        money.text = String(self.user.userCoins)
        
        setText()
        
    }
    
    func setText() {
        Array(user.inventory.foodCollection.keys).forEach { food in
            if food == "Candy" {
                candyCount = user.inventory.foodCollection[food]!
            }
            else if food == "Cookie" {
                cookieCount = user.inventory.foodCollection[food]!
            }
            else if food == "Pizza" {
                pizzaCount = user.inventory.foodCollection[food]!
            }
        }
        
        user.inventory.backgroundCollection.forEach { background in
            if background == "Background_Park" {
                parkText = "Purchased"
            }
            else if background == "Background_Underwater_v2" {
                seaText = "Purchased"
            }
            else if background == "Background_City" {
                cityText = "Purchased"
            }
            
        }
        
        parkText = "Purchased"
        if user.inventory.backgroundUsed == "Background_Park" {
            parkText = "Used"
        }
        else if user.inventory.backgroundUsed == "Background_Underwater_v2" {
            seaText = "Used"
        }
        else if user.inventory.backgroundUsed == "Background_City" {
            cityText = "Used"
        }
        
        parkStatus.text = parkText
        seaStatus.text = seaText
        cityStatus.text = cityText
        candyQty.text = "Qty: \(candyCount)"
        cookieQty.text = "Qty: \(cookieCount)"
        pizzaQty.text = "Qty: \(pizzaCount)"
        parkStatus.text = parkText
        seaStatus.text = seaText
        cityStatus.text = cityText
    }
    
    @IBAction func cityButton(_ sender: UIButton) {
        if self.user.inventory.useBackground(backgroundID: "Background_City") {
            self.user.save()
            setText()
        }
    }
    @IBAction func seaButton(_ sender: UIButton) {
        if self.user.inventory.useBackground(backgroundID: "Background_Underwater_v2") {
            self.user.save()
            setText()
        }
    }
    @IBAction func parkButton(_ sender: UIButton) {
        if self.user.inventory.useBackground(backgroundID: "Background_Park") {
            self.user.save()
            setText()
        }
    }
    @IBAction func pizzaButton(_ sender: UIButton) {
        if self.user.inventory.consumeFood(foodID: "Pizza") {
            self.pizzaCount -= 1
            self.user.hunger += min(storeData.foods["pizza"]!.foodHealth, 100)
            self.user.affection = min(self.user.affection + 5, 100)
            self.user.save()
            setText()
        }
    }
    @IBAction func cookieButton(_ sender: UIButton) {
        if self.user.inventory.consumeFood(foodID: "Cookie") {
            self.cookieCount -= 1
            self.user.hunger += min(storeData.foods["cookie"]!.foodHealth, 100)
            self.user.affection += min(self.user.affection + 5, 100)
            self.user.save()
            setText()
        }
    }
    @IBAction func candyButton(_ sender: UIButton) {
        if self.user.inventory.consumeFood(foodID: "Candy") {
            self.candyCount -= 1
            self.user.hunger += min(storeData.foods["candy"]!.foodHealth, 100)
            self.user.affection += min(self.user.affection + 5, 100)
            self.user.save()
            setText()
        }
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoHome", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoHome" {
            let destinationViewController = segue.destination as? ViewController
            destinationViewController?.user = self.user
        }

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
