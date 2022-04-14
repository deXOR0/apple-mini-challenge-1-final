//
//  ViewController.swift
//  VirtualPet
//
//  Created by Atyanta Awesa Pambharu on 06/04/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var affectionMeter: UIProgressView!
    @IBOutlet weak var hungerMeter: UIProgressView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var money: UITextView!
    
    var user: User = User()
    
    @IBAction func profileButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoProfile", sender: self)
    }
    @IBAction func timerSetter(_ sender: Any, forEvent event: UIEvent) {
        performSegue(withIdentifier: "gotoTimerPrompt", sender: self)
    }

    @IBAction func shop(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoShop", sender: self)
    }
    
    @IBAction func inventory(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoInventory", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        background.image = UIImage(named:  self.user.inventory.backgroundUsed)
        affectionMeter.setProgress(Float(self.user.affection) / 100, animated: false)
        hungerMeter.setProgress(Float(self.user.hunger) / 100, animated: false)
        money.text = String(user.userCoins)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoProfile" {
            let destinationViewController = segue.destination as? ProfileViewController
            destinationViewController?.user = self.user
        }
        else if segue.identifier == "gotoTimerPrompt" {
            let destinationViewController = segue.destination as? TimerPromptViewController
            destinationViewController?.user = self.user
        }
        else if segue.identifier == "gotoShop" {
            let destinationViewController = segue.destination as? ShopViewController
            destinationViewController?.user = self.user
        }
        else if segue.identifier == "gotoInventory" {
            let destinationViewController = segue.destination as? InventoryViewController
            destinationViewController?.user = self.user
        }
    }

}

