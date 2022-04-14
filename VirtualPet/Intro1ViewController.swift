//
//  Intro1ViewController.swift
//  VirtualPet
//
//  Created by Atyanta Awesa Pambharu on 13/04/22.
//

import UIKit

class Intro1ViewController: UIViewController {
    
    var user: User = User()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoIntro2", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoIntro2" {
            let destinationViewController = segue.destination as? SetupGameHoursViewController
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
