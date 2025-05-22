//
//  LocationViewModel.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import YandexMapsMobile

class LocationViewModel: NSObject, YMKMapObjectTapListener {
    
    // MARK: - Properties
    private weak var coordinator: LocationCoordinator?
    private var selectedPlacemark: YMKPlacemarkMapObject?
    private(set) var searchResult: SearchResult?
    
    
    // MARK: - Init
    init(coordinator: LocationCoordinator?, searchResult: SearchResult? = nil) {
        self.coordinator = coordinator
        self.searchResult = searchResult
    }
    
    // MARK: - Navigation Methods
    func pushToSearchResults(delegate: SearchResultsViewControllerDelegate) {
        coordinator?.pushToSearchResults(delegate: delegate)
    }
    
    func presentSearchResultDetail(searchResult: SearchResult) {
        coordinator?.presentSearchResultDetail(searchResult: searchResult)
    }
    
    // MARK: - Map Interaction Methods
    func moveToInitialLocation(on mapView: YMKMapView) {
        let initialPoint = YMKPoint(latitude: 41.2995, longitude: 69.2401)
        moveMap(to: initialPoint, zoom: 13, on: mapView)
    }
    
    func moveToUserLocation(on mapView: YMKMapView) {
        let userLocation = YMKPoint(latitude: 41.2995, longitude: 69.2401)
        updatePlacemark(at: userLocation, on: mapView)
        moveMap(to: userLocation, zoom: 17, on: mapView)
    }
    
    func moveToLocation(latitude: Double, longitude: Double, on mapView: YMKMapView) {
        let locationPoint = YMKPoint(latitude: latitude, longitude: longitude)
        moveMap(to: locationPoint, zoom: 17, on: mapView)
    }
    
    func moveMap(to point: YMKPoint, zoom: Float, on mapView: YMKMapView) {
        let cameraPosition = YMKCameraPosition(target: point, zoom: zoom, azimuth: 0, tilt: 30.0)
        mapView.mapWindow.map.move(with: cameraPosition,
                                   animation: YMKAnimation(type: .smooth, duration: 1),
                                   cameraCallback: nil)
    }
    
    private func updatePlacemark(at point: YMKPoint, on mapView: YMKMapView, shouldPresentDetail: Bool = true) {
        if shouldPresentDetail {
            LocationSearchManager.shared.searchByPoint(point) { [weak self] result in
                guard let self = self, let result = result else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                    guard let self = self else { return }
                    self.presentSearchResultDetail(searchResult: result)
                }
            }

        }
        selectedPlacemark?.addTapListener(with: self)
       // mapView.mapWindow.map.addCameraListener(with: self)
    }
    
    // MARK: - Map Object Delegate Methods
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        guard let placemark = mapObject as? YMKPlacemarkMapObject,
              let searchResult = placemark.userData as? SearchResult else { return false }
        presentSearchResultDetail(searchResult: searchResult)
        return true
    }

}
