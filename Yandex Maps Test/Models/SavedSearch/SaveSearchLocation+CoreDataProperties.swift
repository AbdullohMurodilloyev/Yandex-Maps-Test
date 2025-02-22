//
//  SaveSearchLocation+CoreDataProperties.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 23/02/25.
//
//

import Foundation
import CoreData


extension SaveSearchLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SaveSearchLocation> {
        return NSFetchRequest<SaveSearchLocation>(entityName: "SaveSearchLocation")
    }

    @NSManaged public var address: String?
    @NSManaged public var distance: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String?

}

extension SaveSearchLocation : Identifiable {

}
