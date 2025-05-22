//
//  LocationViewModel.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import YandexMapsMobile

class LocationViewModel: NSObject, YMKMapCameraListener {
    
    // MARK: - Properties
    private weak var coordinator: LocationCoordinator?
    private(set) var searchResult: SearchResult?
    
    // Debounce properties
    private var debounceTimer: Timer?
    private let debounceDelay: TimeInterval = 1.0
    
    // User interaction tracking
    private var hasUserInteracted: Bool = false
    
    // MARK: - Init
    init(coordinator: LocationCoordinator?, searchResult: SearchResult? = nil) {
        self.coordinator = coordinator
        self.searchResult = searchResult
        super.init()
    }
    
    // MARK: - Navigation Methods
    func pushToSearchResults(delegate: SearchResultsViewControllerDelegate) {
        coordinator?.pushToSearchResults(delegate: delegate)
    }
    
    func presentSearchResultDetail(searchResult: SearchResult) {
        coordinator?.presentSearchResultDetail(searchResult: searchResult)
    }
    
    // MARK: - Map Navigation Methods
    func moveToInitialLocation(on mapView: YMKMapView) {
        let initialPoint = YMKPoint(latitude: 41.2995, longitude: 69.2401)
        moveMap(to: initialPoint, zoom: 13, on: mapView)
    }
    
    func moveToUserLocation(on mapView: YMKMapView, performSearch: Bool = false) {
        let userLocation = YMKPoint(latitude: 41.2995, longitude: 69.2401)
        moveMap(to: userLocation, zoom: 17, on: mapView)
        
        if performSearch {
            self.performSearch(at: userLocation)
        }
    }
    
    func moveToLocation(latitude: Double, longitude: Double, on mapView: YMKMapView, performSearch: Bool = false) {
        let locationPoint = YMKPoint(latitude: latitude, longitude: longitude)
        moveMap(to: locationPoint, zoom: 17, on: mapView)

        if performSearch {
            self.performSearch(at: locationPoint)
        }
    }
    
    // MARK: - Private Methods
    private func moveMap(to point: YMKPoint, zoom: Float, on mapView: YMKMapView) {
        let cameraPosition = YMKCameraPosition(
            target: point,
            zoom: zoom,
            azimuth: 0,
            tilt: 30.0
        )
        
        mapView.mapWindow.map.move(
            with: cameraPosition,
            animation: YMKAnimation(type: .smooth, duration: 1),
            cameraCallback: nil
        )
    }
    
    private func performSearch(at point: YMKPoint) {
        LocationSearchManager.shared.searchByPoint(point) { [weak self] result in
            guard let self = self, let result = result else { return }
            
            DispatchQueue.main.async {
                self.presentSearchResultDetail(searchResult: result)
            }
        }
    }
    
    // MARK: - YMKMapCameraListener
    func onCameraPositionChanged(
        with map: YMKMap,
        cameraPosition: YMKCameraPosition,
        cameraUpdateReason: YMKCameraUpdateReason,
        finished: Bool
    ) {
        // Mark user interaction
        if cameraUpdateReason == .gestures {
            hasUserInteracted = true
        }
        
        // Only proceed if user has interacted
        guard hasUserInteracted else { return }
        
        // Cancel previous timer
        debounceTimer?.invalidate()
        
        // Start new timer
        debounceTimer = Timer.scheduledTimer(withTimeInterval: debounceDelay, repeats: false) { [weak self] _ in
            self?.performSearch(at: cameraPosition.target)
        }
    }
    
    // MARK: - Cleanup
    deinit {
        debounceTimer?.invalidate()
    }
}
