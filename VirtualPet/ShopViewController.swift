//
//  ShopViewController.swift
//  VirtualPet
//
//  Created by Sherary Apriliana on 13/04/22.
//

import UIKit

class ShopViewController: UIViewController {
    
    var user: User = User()
    var selectedItem: String = ""
    let storeData = StoreData()

    @IBOutlet weak var money: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        money.text = String(self.user.userCoins)
    }
    
    @IBAction func candyButtonPressed(_ sender: UIButton) {
        self.selectedItem = "candy"
        performSegue(withIdentifier: "food", sender: self)
    }
    
    @IBAction func cookieButtonPressed(_ sender: UIButton) {
        self.selectedItem = "cookie"
        performSegue(withIdentifier: "food", sender: self)
    }
    
    @IBAction func pizzaButttonPressed(_ sender: UIButton) {
        self.selectedItem = "pizza"
        performSegue(withIdentifier: "food", sender: self)
    }
    
    @IBAction func cityButtonPressed(_ sender: UIButton) {
        self.selectedItem = "city"
        performSegue(withIdentifier: "background", sender: self)
    }
    
    @IBAction func parkButtonPressed(_ sender: UIButton) {
        self.selectedItem = "park"
//        performSegue(withIdentifier: "background", sender: self)
    }
    
    @IBAction func seaButtonPressed(_ sender: UIButton) {
        self.selectedItem = "sea"
        performSegue(withIdentifier: "background", sender: self)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoHome", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "food" {
            let destinationViewController = segue.destination as? ShopFoodDetailViewController
            destinationViewController?.user = self.user
            destinationViewController?.selectedItem = self.selectedItem
            destinationViewController?.storeData = storeData.foods
        }
        else if segue.identifier == "background" {
            let destinationViewController = segue.destination as? ShopBackgroundDetailViewController
            destinationViewController?.user = self.user
            destinationViewController?.selectedItem = self.selectedItem
            destinationViewController?.storeData = storeData.backgrounds
        }
        else if segue.identifier == "gotoHome" {
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
