//
//  SavedLocation+CoreDataProperties.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 20/02/25.
//
//

import Foundation
import CoreData


extension SavedLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedLocation> {
        return NSFetchRequest<SavedLocation>(entityName: "SavedLocation")
    }

    @NSManaged public var name: String?
    @NSManaged public var address: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}

extension SavedLocation : Identifiable {

}
