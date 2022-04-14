//
//  ShopFoodDetailViewController.swift
//  VirtualPet
//
//  Created by Atyanta Awesa Pambharu on 14/04/22.
//

import UIKit

class ShopFoodDetailViewController: UIViewController {

    @IBOutlet weak var quantity: UITextView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var money: UITextView!
    @IBOutlet weak var health: UILabel!
    var user: User = User()
    var selectedItem: String = ""
    var storeData: [String: Food] = [String: Food]()
    var count: Int = 1
    var selectedFood: Food = Food(foodID: "", foodName: "", foodImage: UIImage(named: ""), foodHealth: 0, foodPrice: 0, foodDetail: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        money.text = String(user.userCoins)
        quantity.text = String(count)
        if let item = storeData[selectedItem] {
            totalPrice.text = String(count * item.foodPrice)
            image.image = item.foodImage
            name.text = item.foodName
            desc.text = item.foodDetail
            health.text = String(item.foodHealth)
        }
    }
    
    @IBAction func increaseQuantity(_ sender: UIButton) {
        count += 1
        quantity.text = String(count)
        totalPrice.text = String(count * storeData[selectedItem]!.foodPrice)
    }
    
    @IBAction func decreaseQuantity(_ sender: UIButton) {
        count -= 1
        quantity.text = String(count)
        totalPrice.text = String(count * storeData[selectedItem]!.foodPrice)
    }
    
    @IBAction func buyButton(_ sender: UIButton) {
        let price = count * storeData[selectedItem]!.foodPrice
        if user.userCoins >= price {
            user.userCoins -= price
            user.inventory.storeFood(foodID: storeData[selectedItem]!.foodID, quantity: count)
            user.save()
            performSegue(withIdentifier: "gotoShop", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoShop" {
            let destinationViewController = segue.destination as? ShopViewController
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
