//
//  DetailsTableViewController.swift
//  VirtualPet
//
//  Created by Jonathan Andryana on 14/04/22.
//

import UIKit
import SwiftUI

struct Details {
    var emoji : String
    var startTime : String
    var endTime : String
    var gamesPlayed : String
    var sessionDetails : String
}

class DetailsCell : UITableViewCell {
  
    @IBOutlet weak var emojiHolder: UILabel!
    @IBOutlet weak var gamesPlayedHolder: UILabel!
    @IBOutlet weak var timesPlayedHolder: UILabel!
    @IBOutlet weak var sessionDetailsHolder: UILabel!
}

class DetailsTableViewController : UITableViewController {
    
    var user : User = User()
    var date = Calendar.current.startOfDay(for: Date())
    var collection = [Journal]()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.collection.count ?? 0
       }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as! DetailsCell
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        let detail = self.collection[indexPath.row]
        cell.emojiHolder?.text = detail.feelings <= 0.2 ? "😞" : detail.feelings <= 0.4 ? "🙁" : detail.feelings <= 0.6 ? "😐" : detail.feelings <= 0.8 ? "🙂"  : "😆"
        cell.timesPlayedHolder.text = formatter.string(from: detail.startDate) + " - " + formatter.string(from: detail.endDate)
        cell.gamesPlayedHolder?.text = "Games Played : " + detail.gamesPlayed
        cell.sessionDetailsHolder?.text = detail.gamingExperience

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "EEEE, dd-MM-yyyy"
        return dateFormatter.string(from: self.date)
    }
    
    override func viewDidLoad() {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = 250
        collection = user.journalCollection.journals[date] ?? [Journal]()
//        tableView.backgroundView = UIImageView(image: UIImage(named: "skyBackground"))
    }

    
}
