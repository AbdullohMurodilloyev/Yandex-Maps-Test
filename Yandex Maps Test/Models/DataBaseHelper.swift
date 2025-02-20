//
//  DataBaseHelper.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 20/02/25.
//

import Foundation
import CoreData

class DataBaseHelper {
    static let shared = DataBaseHelper()
    
    private init() {} // Singleton'ni tashqaridan init qilishni oldini olamiz
    
    // MARK: - Save Location
    func saveLocation(data: SearchResult) {
        let context = CoreDataManager.shared.context
        
        // Mavjud joyni tekshirish
        if isLocationAlreadySaved(name: data.name) {
            print("Bu joy allaqachon saqlangan!")
            return
        }
        
        let newLocation = SavedLocation(context: context)
        newLocation.name = data.name
        newLocation.address = data.address
        newLocation.latitude = data.latitude
        newLocation.longitude = data.longitude

        do {
            try context.save()
            print("Location saqlandi!")
        } catch {
            print("Xatolik: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Fetch Locations
    func fetchLocations() -> Result<[SavedLocation], Error> {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<SavedLocation> = SavedLocation.fetchRequest()

        do {
            let locations = try context.fetch(fetchRequest)
            return .success(locations)
        } catch {
            return .failure(error)
        }
    }
    
    // MARK: - Delete Location
    func deleteLocation(_ location: SavedLocation, completion: (() -> Void)? = nil) {
        let context = CoreDataManager.shared.context
        context.delete(location)

        do {
            try context.save()
            print("Location o‘chirildi!")
            completion?()
        } catch {
            print("Xatolik: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Check If Location Exists
    private func isLocationAlreadySaved(name: String) -> Bool {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<SavedLocation> = SavedLocation.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let result = try context.fetch(fetchRequest)
            return !result.isEmpty
        } catch {
            print("Tekshirishda xatolik: \(error.localizedDescription)")
            return false
        }
    }
}


