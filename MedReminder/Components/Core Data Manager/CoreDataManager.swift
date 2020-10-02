//
//  CoreDataManager.swift
//  MedReminder
//
//  Created by Sharad on 02/10/20.
//

import Foundation
import CoreData

final class CoreDataManager {
  
    static let sharedManager = CoreDataManager()
    
    private init() {}
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "MedReminder")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

  
    func insertMedicineInformation(_ dateString: String, _ keyPath: String) {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        if let medicineHistory = checkIfEntryAlreadyExists(dateString) {
            medicineHistory.setValue(Date(), forKey: keyPath)
        } else {
            let entity = NSEntityDescription.entity(forEntityName: "MedicineHistory",
                                                  in: managedContext)!
            let medicine = NSManagedObject(entity: entity,
                                       insertInto: managedContext)
            medicine.setValue(Date(), forKeyPath: keyPath)
            medicine.setValue(dateString, forKeyPath: "currentDate")
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
 
    func checkIfEntryAlreadyExists(_ dateString: String) -> MedicineHistory? {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MedicineHistory")
        fetchRequest.predicate = NSPredicate(format: "currentDate = %@", dateString)
        
        do {
            if let fetchResults = try managedContext.fetch(fetchRequest) as? [MedicineHistory], !fetchResults.isEmpty {
                return fetchResults[0]
            } else {
                return nil
            }
        } catch {
            return nil
        }
        
    }
  
    func fetchMedicineHistory() -> [MedicineHistory]? {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MedicineHistory")
        do {
            let people = try managedContext.fetch(fetchRequest)
            return people as? [MedicineHistory]
        } catch {
            return nil
        }
    }
  
}


