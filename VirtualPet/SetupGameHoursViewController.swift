//
//  SetupGameHoursViewController.swift
//  VirtualPet
//
//  Created by Sherary Apriliana on 13/04/22.
//

import UIKit

class SetupGameHoursViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var user: User = User()
    var hours: Int = 0
    var minutes: Int = 0
    
    let timeOptions = [
        [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24],
        [0,15,30,45]
    ]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return timeOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeOptions[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(timeOptions[component][row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch (component) {
        case 0:
            hours = timeOptions[component][row]
        case 1:
            minutes = timeOptions[component][row]
        default:break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func SaveGameHours(_ sender: UIButton) {
        if (self.hours == 24 && self.minutes == 0) || (self.minutes == 0 && self.hours > 0) || (self.hours >= 0 && self.hours <= 23 && self.minutes > 0 && self.minutes <= 45) {
            self.user.gamingTargetTime = (self.hours * 3600) + (self.minutes * 60)
            performSegue(withIdentifier: "gotoLetsDoThis", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoLetsDoThis" {
            let destinationViewController = segue.destination as? LetsDoThisViewController
            destinationViewController?.user = self.user
        }
    }
}
