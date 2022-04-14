//
//  Journal.swift
//  VirtualPet
//
//  Created by Jonathan Andryana on 10/04/22.
//
import Foundation
import UIKit

struct Journal: Codable {
    var journalID: String
    var startDate : Date
    var endDate : Date
    var elapsedTime: Int
    var feelings : Float
    var gamesPlayed : String
    var gamingExperience : String
    
    init(journalID: String, startDate: Date, endDate: Date, feelings: Float, gamesPlayed: String, gamingExperience: String) {
        self.journalID = journalID
        self.startDate = startDate
        self.endDate = endDate
        self.elapsedTime = Int(endDate.timeIntervalSinceReferenceDate - startDate.timeIntervalSinceReferenceDate) //Int(startDate.timeIntervalSince(endDate))
        self.feelings = feelings
        self.gamesPlayed = gamesPlayed
        self.gamingExperience = gamingExperience
    }
}
