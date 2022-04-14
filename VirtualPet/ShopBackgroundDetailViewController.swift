//
//  ShopBackgroundDetailViewController.swift
//  VirtualPet
//
//  Created by Atyanta Awesa Pambharu on 14/04/22.
//

import UIKit

class ShopBackgroundDetailViewController: UIViewController {

    var user: User = User()
    var selectedItem: String = ""
    var storeData: [String: Background] = [String: Background]()
    
    
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var money: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        money.text = String(user.userCoins)
        if let item = storeData[selectedItem] {
            totalPrice.text = String(item.backgroundPrice)
            image.image = item.backgroundImage
            name.text = item.backgroundName
            desc.text = item.backgroundDetail
        }
        
    }
    
    @IBAction func buyButton(_ sender: UIButton) {
        let price = storeData[selectedItem]!.backgroundPrice
        let id = storeData[selectedItem]!.backgroundID
        if user.userCoins >= price {
            user.userCoins -= price
            user.inventory.storeBackground(backgroundID: id)
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
