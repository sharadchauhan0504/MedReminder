//
//  NotificationManager.swift
//  MedReminder
//
//  Created by Sharad on 02/10/20.
//

import Foundation
import NotificationCenter

struct MedicineInformation {
    let dateComponent: DateComponents
    let title: String
    let message: String
    let identifier: String
}

final class NotificationManager {
    
    
    static let shared = NotificationManager()
    
    //MARK:- Init
    private init() {}
    
    //MARK:- Public methods
    func scheduleNotifications() {
        removeAllPendingAndDeliveredNotifications()
        
        getToBeScheduledDates()
            .forEach {getMedicineTimes(date: $0)
                .forEach { scheduleNotificationFor(title: $0.title, body: $0.message, identifier: $0.identifier, time: $0.dateComponent)} }
        
    }

    func removeRecentNotification() {
        let identifier = getIdentifier()
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
    func removeAllPendingAndDeliveredNotifications() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    //MARK:- Private methods
    private func getToBeScheduledDates() -> [Date] {
        let currentDate = Date()
        guard let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate), let nextToNextDate = Calendar.current.date(byAdding: .day, value: 2, to: currentDate) else {return [currentDate]}
        return [currentDate, nextDate, nextToNextDate]
    }
    
    private func getMedicineTimes(date: Date) -> [MedicineInformation] {
        let currentDate = Date()
        let day         = Calendar(identifier: .gregorian).component(.day, from:currentDate)
        let year        = Calendar(identifier: .gregorian).component(.year, from:currentDate)
        return [
            MedicineInformation(dateComponent: DateComponents(day: day, hour: 11, minute: 00), title: "Morning Medicine", message: "Time to take your morning medicine. Stay healthy!", identifier: "morning_\(day)_11_00_\(year)"),
            MedicineInformation(dateComponent: DateComponents(day: day, hour: 17, minute: 37), title: "Afternoon Medicine", message: "Time to take your afternoon medicine. Stay healthy!", identifier: "afternoon_\(day)_14_00_\(year)"),
            MedicineInformation(dateComponent: DateComponents(day: day, hour: 20, minute: 00), title: "Evening Medicine", message: "Time to take your evening medicine. Stay healthy!", identifier: "evening_\(day)_20_00_\(year)")
            ]
    }
    
    private func scheduleNotificationFor(title: String, body: String, identifier: String, time: DateComponents) {
        let notifContent   = UNMutableNotificationContent()
        notifContent.title = title
        notifContent.body  = body

        let notifTrigger   = UNCalendarNotificationTrigger(dateMatching: time, repeats: false)
        let notifRequest   = UNNotificationRequest(identifier: identifier, content: notifContent, trigger: notifTrigger)

        UNUserNotificationCenter.current().add(notifRequest, withCompletionHandler: nil)
    }

    private func getIdentifier() -> String {
        let currentDate = Date()
        let day         = Calendar(identifier: .gregorian).component(.day, from: currentDate)
        let year        = Calendar(identifier: .gregorian).component(.year, from: currentDate)
        let hour        = Calendar(identifier: .gregorian).component(.hour, from: currentDate)
        
        if hour < 11 {
            return "morning_\(day)_11_00_\(year)"
        } else if hour < 14  {
            return "afternoon_\(day)_14_00_\(year)"
        } else if hour < 20 {
            return "evening_\(day)_20_00_\(year)"
        } else {
            return ""
        }
    }
    
}
