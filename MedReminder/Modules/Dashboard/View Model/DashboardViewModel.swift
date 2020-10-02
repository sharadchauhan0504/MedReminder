//
//  DashboardViewModel.swift
//  MedReminder
//
//  Created by Sharad on 02/10/20.
//

import Foundation
import UserNotifications

class DashboardViewModel {
    
    func isTimeForMedicine() -> (Bool, String?) {
        let currentDate = Date()
        let hour        = Calendar(identifier: .gregorian).component(.hour, from: currentDate)
        let minute      = Calendar(identifier: .gregorian).component(.minute, from: currentDate)
        let minuteCondition = minute > 45 || minute < 30
                
        if (hour == 11 || hour == 10) && minuteCondition {
            return (true, "morningTime")
        } else if (hour == 14 || hour == 13) && minuteCondition {
            return (true, "afternoonTime")
        } else if (hour == 20 || hour == 19) && minuteCondition {
            return (true, "eveningTime")
        }
        return (false, nil)
    }
    
    func getTodaysScore() -> String {
        let todaysData = CoreDataManager.sharedManager.checkIfEntryAlreadyExists(Date().getConvertedDateString("yyyy-MM-dd"))
        guard let data = todaysData else {return "0"}
        
        var score = 0
        if let _ = data.morningTime {
            score += 30
        }
        if let _ = data.afternoonTime {
            score += 30
        }
        if let _ = data.eveningTime {
            score += 40
        }
        return "\(score)"
    }
    
    func askForNotificationPermission(completion: @escaping((Bool) -> Void)) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            granted ? completion(true) : completion(false)
        }
    }
}
