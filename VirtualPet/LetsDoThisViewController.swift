//
//  LetsDoThisViewController.swift
//  VirtualPet
//
//  Created by Atyanta Awesa Pambharu on 13/04/22.
//

import UIKit

class LetsDoThisViewController: UIViewController {

    var user: User = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func letsGoButtonPressed(_ sender: UIButton) {
        self.user.isNewUser = false
        self.user.resetGamingQuota()
        self.user.injectData()
        self.user.save()
        performSegue(withIdentifier: "gotoHome", sender: self)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoHome" {
            self.user.isNewUser = false
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
