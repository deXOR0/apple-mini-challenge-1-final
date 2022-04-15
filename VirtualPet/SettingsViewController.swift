//
//  SettingsViewController.swift
//  VirtualPet
//
//  Created by Atyanta Awesa Pambharu on 15/04/22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var user: User = User()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetUserDataButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Reset User Data", message: "Are you sure you want to reset user data? This action cannot be undone!", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Accept", style: .destructive, handler: { action in
            self.user.reset()
            self.performSegue(withIdentifier: "gotoInitialLoadView", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
