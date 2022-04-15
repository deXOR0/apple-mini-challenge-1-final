//
//  User.swift
//  VirtualPet
//
//  Created by Sherary Apriliana on 10/04/22.
//

import Foundation

class User: Codable {
    var name: String = ""
    var isNewUser: Bool = true
    let maxCoins = 99999
    let minCoins = 50
    let maxLevel = 10
    var userCoins: Int = 500
    var userLevel: Int = 1
    var userExperience: Int = 0
    var lastLoggedIn: Date = Date()
    var gamingQuotaLeft: Int = 0
    var gamingTargetTime: Int = 0
    var hunger: Int = 50
    var affection: Int = 50
    let dailyHungerDrain: Int = 30
    let dailyAffectionDrain: Int = 5
    var journalCollection: JournalCollection = JournalCollection()
    var inventory: Inventory = Inventory()
    let userDefault: UserDefaults = UserDefaults.standard
    let USER_KEY = "user_key"

    func loadSavedUser() -> Bool {
        if let data = self.userDefault.data(forKey: self.USER_KEY) {
            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode(User.self, from: data)
                self.name = user.name
                self.isNewUser = false
                self.userCoins = user.userCoins
                self.userLevel = user.userLevel
                self.userExperience = user.userExperience
                self.lastLoggedIn = user.lastLoggedIn
                self.gamingQuotaLeft = user.gamingQuotaLeft
                self.gamingTargetTime = user.gamingTargetTime
                self.journalCollection = user.journalCollection
                self.inventory = user.inventory
                if !Calendar.current.isDateInToday(self.lastLoggedIn) {
                    resetGamingQuota()
                }
                save()
                return true
            } catch {
                // Fallback
            }
        }
        return false
    }
    
    func injectData() {
        self.inventory.storeBackground(backgroundID: "Background_Park")
        journalCollection.addJournal(todaysDate: getDate(dateStr: "2022-04-08T11:42:00"), journal: Journal(journalID: "2022-04-08T11:42:00", startDate: getDate(dateStr: "2022-04-08T09:42:00"), endDate: getDate(dateStr: "2022-04-08T11:42:00"), feelings: 0.5, gamesPlayed: "Counter Strike", gamingExperience: "Mantap"))
        journalCollection.addJournal(todaysDate: getDate(dateStr: "2022-04-08T14:42:00"), journal: Journal(journalID: "2022-04-08T14:42:00", startDate: getDate(dateStr: "2022-04-08T11:42:00"), endDate: getDate(dateStr: "2022-04-08T14:42:00"), feelings: 0.5, gamesPlayed: "Counter Strike", gamingExperience: "Mantap"))
        journalCollection.addJournal(todaysDate: getDate(dateStr: "2022-04-09T11:42:00"), journal: Journal(journalID: "2022-04-09T11:42:00", startDate: getDate(dateStr: "2022-04-09T08:42:00"), endDate: getDate(dateStr: "2022-04-09T11:42:00"), feelings: 0.5, gamesPlayed: "Counter Strike", gamingExperience: "Mantap"))
        journalCollection.addJournal(todaysDate: getDate(dateStr: "2022-04-09T17:30:00"), journal: Journal(journalID: "2022-04-09T17:30:00", startDate: getDate(dateStr: "2022-04-09T12:30:00"), endDate: getDate(dateStr: "2022-04-09T17:30:00"), feelings: 0.9, gamesPlayed: "Valorant", gamingExperience: "Saya belom tidur dari tanggal 13 kak :)"))
        journalCollection.addJournal(todaysDate: getDate(dateStr: "2022-04-10T11:42:00"), journal: Journal(journalID: "2022-04-10T11:42:00", startDate: getDate(dateStr: "2022-04-10T07:42:00"), endDate: getDate(dateStr: "2022-04-10T11:42:00"), feelings: 0.3, gamesPlayed: "Genshin Impact", gamingExperience: "I dont like rpg"))
        journalCollection.addJournal(todaysDate: getDate(dateStr: "2022-04-11T11:42:00"), journal: Journal(journalID: "2022-04-11T11:42:00", startDate: getDate(dateStr: "2022-04-11T10:42:00"), endDate: getDate(dateStr: "2022-04-11T11:42:00"), feelings: 0.6, gamesPlayed: "Counter Strike", gamingExperience: "Mantap"))
        journalCollection.addJournal(todaysDate: getDate(dateStr: "2022-04-13T14:00:00"), journal: Journal(journalID: "2022-04-13T14:00:00", startDate: getDate(dateStr: "2022-04-13T11:30:00"), endDate: getDate(dateStr: "2022-04-13T14:00:00"), feelings: 0.5, gamesPlayed: "Counter Strike", gamingExperience: "Kalah ranked :("))
        journalCollection.addJournal(todaysDate: getDate(dateStr: "2022-04-13T17:15:00"), journal: Journal(journalID: "2022-04-13T17:15:00", startDate: getDate(dateStr: "2022-04-13T15:00:00"), endDate: getDate(dateStr: "2022-04-13T17:15:00"), feelings: 0.5, gamesPlayed: "Mobile Legends", gamingExperience: "Ngabuburit om"))
        journalCollection.addJournal(todaysDate: getDate(dateStr: "2022-04-14T13:30:00"), journal: Journal(journalID: "2022-04-14T13:30:00", startDate: getDate(dateStr: "2022-04-14T12:30:00"), endDate: getDate(dateStr: "2022-04-14T13:30:00"), feelings: 0.7, gamesPlayed: "Valorant", gamingExperience: "Mantap banget"))
        
    }
    
    func getDate(dateStr: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: dateStr) ?? Date() // "2015-04-01T11:42:00"
    }

    func save() {
        do {
            let user = self
            let encoder = JSONEncoder()
            let data = try encoder.encode(user)
            self.userDefault.set(data, forKey: self.USER_KEY)
        } catch {
            // Fallback
        }
    }
    
    func reset() {
        userDefault.removeObject(forKey: USER_KEY)
    }

    func resetGamingQuota() {
        self.gamingQuotaLeft = self.gamingTargetTime
        self.lastLoggedIn = Date()
    }
    
    func decreaseHunger() {
        //tiap hari berkurang 30, stops at 0
        self.hunger = max(self.hunger - self.dailyHungerDrain, 0)
    }
    
    func decreaseAffection() {
        //tiap hari berkurang 5, stops at 0
        self.affection = max(self.affection - self.dailyAffectionDrain, 0)
    }

    func getLastWeekActivity() -> [TimePlayed] {
        var activity = [TimePlayed]()
        
        for i in stride(from: 6, to: -1, by: -1) {
            if let date = Calendar.current.date(byAdding: .day, value: -i, to: Date()) {
                let key = Calendar.current.startOfDay(for: date)
                var totalTime = 0
                if let journalArray = self.journalCollection.journals[key] {
                    journalArray.forEach { j in
                        let duration = j.endDate.timeIntervalSince(j.startDate)
                        totalTime += Int(duration)
                    }
                }
                activity.append(TimePlayed(date: key, playTimeInSeconds: totalTime))
            }
        }
        
        return activity
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case isNewUser
        case userCoins
        case userLevel
        case userExperience
        case lastLoggedIn
        case gamingQuotaLeft
        case gamingTargetTime
        case journalCollection
        case inventory
    }
}
