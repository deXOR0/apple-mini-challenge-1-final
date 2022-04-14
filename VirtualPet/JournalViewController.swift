//
//  JournalViewController.swift
//  VirtualPet
//
//  Created by Jonathan Andryana on 12/04/22.
//

import UIKit

class JournalViewController: UIViewController {
    
    var user: User = User()
    var newJournal = Journal(journalID: "", startDate: Date(), endDate: Date(), feelings: 0, gamesPlayed: "", gamingExperience: "")
    var startDate: Date = Date()
    var endDate: Date = Date()
    var elapsedTime: Int = 0
    var feelings: Float = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(self.elapsedTime)
        print(self.startDate)
        print(self.endDate)
    }
    

    
    @IBOutlet weak var gamingExperienceInput: UITextView!
    @IBOutlet weak var gamesPlayedInput: UITextView!
    @IBOutlet weak var emojiHolder: UILabel!
    
    @IBAction func emojiSlider(_ sender: UISlider) {
        let currValue = Float(sender.value)
        
        self.feelings = currValue
        
        emojiHolder.text = currValue <= 0.2 ? "😞" : currValue <= 0.4 ? "🙁" : currValue <= 0.6 ? "😐" : currValue <= 0.8 ? "🙂"  : "😆"

    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        if let gamesPlayed = gamesPlayedInput.text {
            if gamesPlayed.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 {
                newJournal.gamesPlayed = gamesPlayed
            }
        }
        if let gamingExperience = gamingExperienceInput.text {
            if gamingExperience.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 {
                newJournal.gamingExperience = gamingExperience
            }
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        newJournal.journalID = dateFormatter.string(from: endDate)
        newJournal.startDate = self.startDate
        newJournal.endDate = self.endDate
        newJournal.elapsedTime = self.elapsedTime
        newJournal.feelings = self.feelings
        
        let key = Calendar.current.startOfDay(for: endDate)
        
        self.user.journalCollection.addJournal(todaysDate: key, journal: newJournal)
        self.user.save()
        
        performSegue(withIdentifier: "gotoOverview", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoOverview" {
            let destinationViewController = segue.destination as? OverviewViewController
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
