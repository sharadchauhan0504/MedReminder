//
//  MedicineHistory+CoreDataProperties.swift
//  MedReminder
//
//  Created by Sharad on 02/10/20.
//
//

import Foundation
import CoreData


extension MedicineHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MedicineHistory> {
        return NSFetchRequest<MedicineHistory>(entityName: "MedicineHistory")
    }

    @NSManaged public var morningTime: Date?
    @NSManaged public var afternoonTime: Date?
    @NSManaged public var eveningTime: Date?
    @NSManaged public var currentDate: String?

}

extension MedicineHistory : Identifiable {

}
