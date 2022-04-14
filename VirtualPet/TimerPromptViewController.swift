//
//  TimerPromptViewController.swift
//  VirtualPet
//
//  Created by Atyanta Awesa Pambharu on 13/04/22.
//

import UIKit

class TimerPromptViewController: UIViewController {

    @IBOutlet weak var targetTimeLabel: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var promptView: UIView!
    @IBOutlet weak var dimmerView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var user: User = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        promptView.layer.cornerRadius = 10
        timeView.layer.cornerRadius = 8
        timeView.layer.borderWidth = 1
        timeView.layer.borderColor = UIColor(red: 0.59, green: 0.59, blue: 0.59, alpha: 1.00).cgColor
        backgroundImage.image = UIImage(named: self.user.inventory.backgroundUsed)
        dimmerView.layer.opacity = 0.4
        
        let timeLeftString = buildTimeString(sec: self.user.gamingQuotaLeft)
        
        let targetTimeString = buildTimeString(sec: self.user.gamingTargetTime)
        
        timeLeftLabel.text = timeLeftString
        targetTimeLabel.text = targetTimeString
        
        if self.user.gamingQuotaLeft <= 0 {
            changeTimerLabelColorDanger()
        }
        
    }
    @IBAction func backButton(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoHome", sender: self)
    }
    
    func changeTimerLabelColorDanger() {
        timeLeftLabel.textColor = UIColor.red
    }
    
    func secToHMS(sec: Int) -> (Int, Int, Int) {
        return ((sec / 3600), ((sec % 3600) / 60), ((sec % 3600) % 60))
    }
    
    func buildTimeString(sec: Int) -> String {
        let time = secToHMS(sec: sec)
        let h = time.0
        let m = time.1
        let s = time.2
        var timeString = ""
        timeString += String(format: "%02d", h)
                timeString += ":"
                timeString += String(format: "%02d", m)
                timeString += ":"
                timeString += String(format: "%02d", s)
                return timeString
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoTimer", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoTimer" {
            let destinationViewController = segue.destination as? TimerViewController
            destinationViewController?.user = self.user
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
