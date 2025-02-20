//
//  LocationViewModel.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import YandexMapsMobile

class LocationViewModel {
    private weak var coordinator: LocationCoordinator?
    
    init(coordinator: LocationCoordinator?) {
        self.coordinator = coordinator
    }
    
    func pushToSearchResults(delegate: SearchResultsViewControllerDelegate) {
        coordinator?.pushToSearchResults(delegate: delegate)
    }
    
    func moveToInitialLocation(on mapView: YMKMapView) {
        let initialPoint = YMKPoint(latitude: 41.2995, longitude: 69.2401)
        moveMap(to: initialPoint, zoom: 11, on: mapView)
    }
    
    func moveToUserLocation(on mapView: YMKMapView) {
        let userLocation = YMKPoint(latitude: 41.2995, longitude: 69.2401) // Replace with actual user location logic
        moveMap(to: userLocation, zoom: 14, on: mapView)
    }
    
    func moveToLocation(latitude: Double, longitude: Double, on mapView: YMKMapView) {
        let locationPoint = YMKPoint(latitude: latitude, longitude: longitude)
        addPlacemark(at: locationPoint, on: mapView)
        moveMap(to: locationPoint, zoom: 15, on: mapView)
    }
    
    private func moveMap(to point: YMKPoint, zoom: Float, on mapView: YMKMapView) {
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(target: point, zoom: zoom, azimuth: 0, tilt: 30.0),
            animationType: YMKAnimation(type: .smooth, duration: 1),
            cameraCallback: nil
        )
    }
    
    private func addPlacemark(at point: YMKPoint, on mapView: YMKMapView) {
        let mapObjects = mapView.mapWindow.map.mapObjects
        mapObjects.clear()
        let placemark = mapObjects.addPlacemark(with: point)
        placemark.setIconWith(UIImage(named: "pin") ?? UIImage())
    }
}
