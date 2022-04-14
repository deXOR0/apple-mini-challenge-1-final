//
//  ProfileViewController.swift
//  VirtualPet
//
//  Created by Atyanta Awesa Pambharu on 12/04/22.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var calendarBackgroundView: UIView!
    @IBOutlet weak var calendarView: UIDatePicker!
    @IBOutlet weak var barChartView: UIView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var user: User = User()
    var date: Date = Calendar.current.startOfDay(for: Date())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        calendarBackgroundView.layer.cornerRadius = 10;
        calendarBackgroundView.layer.masksToBounds = true;
        
        barChartView.layer.cornerRadius = 10;
        barChartView.layer.masksToBounds = true;
        
        let barChart = BarChart(barChartView: barChartView)
        
        /// Dummy Data
        /// Change with data from user
        
        let userName = user.name
        let userLevel = user.userLevel
        
        let targetTime = user.gamingTargetTime
        let activity: [TimePlayed] = user.getLastWeekActivity()
        
        print("OK")
        print(activity)
        
        barChart.setupBarChart(targetTimeInSeconds: targetTime, lastWeekActivity: activity)
        usernameLabel.text = userName
        levelLabel.text = "LV. \(userLevel)"

    }
    
    @IBAction func calendarValueChanged(_ sender: UIDatePicker) {
        self.date = Calendar.current.startOfDay(for: sender.date)
        print(date)
        if let pickedDate = self.user.journalCollection.journals[date] {
            performSegue(withIdentifier: "gotoJournalDetails", sender: self)
        }
        /// if sender.date exists in user journalCollection, performSegue with data: sender.date
        /// else do nothing
    }

    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "backToHome", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToHome" {
            let destinationViewController = segue.destination as? ViewController
            destinationViewController?.user = self.user
        }
        else if segue.identifier == "gotoJournalDetails" {
            let destinationViewController = segue.destination as? DetailsTableViewController
            destinationViewController?.user = self.user
            destinationViewController?.date = self.date
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
