//
//  LocationViewModel.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import YandexMapsMobile

class LocationViewModel: NSObject, YMKMapObjectTapListener {
    private weak var coordinator: LocationCoordinator?
    private var searchSession: YMKSearchSession?
    private var selectedPlacemark: YMKPlacemarkMapObject?
    
    init(coordinator: LocationCoordinator?) {
        self.coordinator = coordinator
    }
    
    func pushToSearchResults(delegate: SearchResultsViewControllerDelegate) {
        coordinator?.pushToSearchResults(delegate: delegate)
    }
    
    func presentSearchResultDetail(searchResult: SearchResult) {
        coordinator?.presentSearchResultDetail(searchResult: searchResult)
    }
    
    func moveToInitialLocation(on mapView: YMKMapView) {
        let initialPoint = YMKPoint(latitude: 41.2995, longitude: 69.2401)
        moveMap(to: initialPoint, zoom: 11, on: mapView)
    }
    
    func moveToUserLocation(on mapView: YMKMapView) {
        let userLocation = YMKPoint(latitude: 41.2995, longitude: 69.2401)
        addSelectedPlacemark(at: userLocation, on: mapView)
        moveMap(to: userLocation, zoom: 15, on: mapView)
    }
    
    func moveToLocation(latitude: Double, longitude: Double, on mapView: YMKMapView) {
        let locationPoint = YMKPoint(latitude: latitude, longitude: longitude)
        addSelectedPlacemark(at: locationPoint, on: mapView)
        moveMap(to: locationPoint, zoom: 15, on: mapView)
    }
    
    private func moveMap(to point: YMKPoint, zoom: Float, on mapView: YMKMapView) {
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(target: point, zoom: zoom, azimuth: 0, tilt: 30.0),
            animationType: YMKAnimation(type: .smooth, duration: 1),
            cameraCallback: nil
        )
    }
    
    private func addSelectedPlacemark(at point: YMKPoint, on mapView: YMKMapView) {
        let mapObjects = mapView.mapWindow.map.mapObjects
        selectedPlacemark?.parent.remove(with: selectedPlacemark!)
        
        selectedPlacemark = mapObjects.addPlacemark(with: point)
        selectedPlacemark?.setIconWith(UIImage(named: "pin") ?? UIImage())
        
        fetchPlaceName(for: point) { [weak self] name, address in
            self?.selectedPlacemark?.userData = SearchResult(
                name: name,
                address: address,
                latitude: point.latitude,
                longitude: point.longitude,
                distance: "")
            print("Joy nomi: \(name), Manzil: \(address)")
        }
        
        selectedPlacemark?.addTapListener(with: self)
    }
    
    // **Placemark bosilganda SearchResult ma'lumotlarini ochish**
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        if let searchResult = mapObject.userData as? SearchResult {
            presentSearchResultDetail(searchResult: searchResult)
        }
        return true
    }
    
    
    func fetchPlaceName(for point: YMKPoint, completion: @escaping (String, String) -> Void) {
        let searchManager = YMKSearch.sharedInstance().createSearchManager(with: .combined)
        let searchOptions = YMKSearchOptions()
        searchOptions.resultPageSize = 1

        searchSession = searchManager.submit(
            with: point,
            zoom: 18,
            searchOptions: searchOptions
        ) { [weak self] response, error in
            guard let self = self else { return }
            
            if let response = response, let firstResult = response.collection.children.first?.obj {
                let name = firstResult.name ?? "Noma'lum joy"
                let address = firstResult.descriptionText ?? "Manzil mavjud emas"
                completion(name, address)
            } else {
                print("Search error: \(error?.localizedDescription ?? "Unknown error")")
                completion("Noma'lum joy", "Manzil mavjud emas")
            }
        }
    }

    
}


