//
//  OverviewViewController.swift
//  VirtualPet
//
//  Created by Jonathan Andryana on 13/04/22.
//

import UIKit

class OverviewViewController: UIViewController {
    
    @IBOutlet weak var barChartView: UIView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var overviewText: UILabel!
    
    var user: User = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
          
        let barChart = BarChart(barChartView: barChartView)
        
        let targetTime = self.user.gamingTargetTime
        let activity: [TimePlayed] = self.user.getLastWeekActivity()
        
        barChart.setupBarChart(targetTimeInSeconds: targetTime, lastWeekActivity: activity)
        
        var message = ""
        var missedDays = 0
        var timeSpent = 0
        var avgTime : Float = 0
        
//        activity.append(TimePlayed(date: Date(), playTimeInSeconds: 5 * 3600))
        
        for each in activity {
            if each.playTimeInSeconds > user.gamingTargetTime{
                timeSpent = timeSpent + each.playTimeInSeconds
                    missedDays += 1
            }
        }
        
        avgTime = Float(timeSpent) / 3600 / Float(activity.count)
        
        if missedDays > 0 {
            message =  "You missed your goal for \(missedDays) day(s)"
        }
        else {
            message = "You successfully reached your goal!"
        }
        
//        overviewText.sizeToFit()
//        overviewText.adjustsFontSizeToFitWidth = true
//        overviewText.layer.masksToBounds = true
//        overviewText.textAlignment = NSTextAlignment.center
        overviewText.text = "On Average you spent \(avgTime) hours of gaming\n \n" + message
    }
    
    
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "gotoResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoResults" {
            let destinationViewController = segue.destination as? ResultsViewController
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
