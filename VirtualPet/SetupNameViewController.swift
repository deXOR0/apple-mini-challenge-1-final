//
//  SetupNameViewController.swift
//  VirtualPet
//
//  Created by Sherary Apriliana on 12/04/22.
//

import UIKit

class SetupNameViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    var user: User = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func SaveName(_ sender: UIButton) {
        if let name = nameField.text {
            if name.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 {
                self.user.name = name
                performSegue(withIdentifier: "gotoSetupGameHours", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoSetupGameHours" {
            let destinationViewController = segue.destination as? SetupGameHoursViewController
            destinationViewController?.user = self.user
        }
    }
}

