//
//  InitialLoadViewController.swift
//  VirtualPet
//
//  Created by Atyanta Awesa Pambharu on 14/04/22.
//

import UIKit

class InitialLoadViewController: UIViewController {
    
    var user: User = User()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if user.loadSavedUser() {
            print("User loaded")
            performSegue(withIdentifier: "gotoHome", sender: self)
        }
        else {
            print("User created")
            performSegue(withIdentifier: "gotoIntro", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoHome" {
            let destinationViewController = segue.destination as? ViewController
            destinationViewController?.user = self.user
        }
        else if segue.identifier == "gotoIntro" {
            let destinationViewController = segue.destination as? Intro1ViewController
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
