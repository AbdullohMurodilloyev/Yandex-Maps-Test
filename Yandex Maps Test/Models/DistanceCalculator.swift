//
//  DistanceCalculator.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 22/02/25.
//

import CoreLocation
import YandexMapsMobile

 // Utility class for distance calculation
struct DistanceCalculator {
    static func calculateDistance(to point: YMKPoint) -> String {
        let tashkentLocation = CLLocation(latitude: 41.364521, longitude: 69.281377)
        let resultLocation = CLLocation(latitude: point.latitude, longitude: point.longitude)
        let distanceInMeters = tashkentLocation.distance(from: resultLocation)
        
        return distanceInMeters < 1000 ?
        String(format: "%.0f m", distanceInMeters) :
        String(format: "%.1f km", distanceInMeters / 1000)
    }
}

