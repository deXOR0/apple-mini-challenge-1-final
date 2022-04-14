//
//  ResultsViewController.swift
//  VirtualPet
//
//  Created by Jonathan Andryana on 13/04/22.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var oodinHolder: UIImageView!
    @IBOutlet weak var levelBar: UIProgressView!
    @IBOutlet weak var resultMessage: UILabel!
    @IBOutlet weak var levelHolder: UILabel!
    @IBOutlet weak var expGained: UILabel!
    @IBOutlet weak var expRange: UILabel!
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var bottomOverlayView: UIView!
    
    var user : User = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        background.image = UIImage(named: user.inventory.backgroundUsed)
        bottomOverlayView.layer.opacity = 0.5
        
        var xpAdd = 30
        
        var message = "Good job, keep it up!"
        oodinHolder.image = UIImage(named: "Pet_Success")
        if  self.user.gamingQuotaLeft < 0 {
            self.user.gamingQuotaLeft = 0
            message = "Let’s do better next time."
            xpAdd = 0
            oodinHolder.image = UIImage(named: "Pet_Failed")
        }
        
        user.userExperience += xpAdd
        
        if user.userExperience >= 100 {
            user.userLevel += 1
            user.userExperience %= 100
        }
        user.save()
        
        levelHolder.text = "Level " + String(user.userLevel)
        expRange.text = "Xp \(user.userExperience)/100"
        expGained.text = "+ \(xpAdd) xp"
        
        resultMessage.text = message
        
        UIView.animate(withDuration: 3){
            self.levelBar.setProgress(Float(self.user.userExperience)/100, animated: true)
        }
    }
    

    @IBAction func continueButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoHome", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoHome" {
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
