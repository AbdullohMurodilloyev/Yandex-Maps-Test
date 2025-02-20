//
//  CoreDataManager.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 20/02/25.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    private init() {
        persistentContainer = NSPersistentContainer(name: "Yandex Maps Test")
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Core Data yuklashda xatolik: \(error)")
            }
        }
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Saqlashda xatolik: \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
