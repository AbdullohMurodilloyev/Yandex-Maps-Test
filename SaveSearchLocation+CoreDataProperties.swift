//
//  SaveSearchLocation+CoreDataProperties.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 22/02/25.
//
//

import Foundation
import CoreData


extension SaveSearchLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SaveSearchLocation> {
        return NSFetchRequest<SaveSearchLocation>(entityName: "SaveSearchLocation")
    }

    @NSManaged public var address: String?
    @NSManaged public var name: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var distance: String?

}

extension SaveSearchLocation : Identifiable {

}
