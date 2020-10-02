//
//  DateExtensions.swift
//  MedReminder
//
//  Created by Sharad on 02/10/20.
//

import Foundation

extension Date {
    
    func getConvertedDateString(_ dateFormat: String) -> String {
        let outputFormatter        = DateFormatter()
        outputFormatter.dateFormat = dateFormat
        return outputFormatter.string(from: self)
    }
}
