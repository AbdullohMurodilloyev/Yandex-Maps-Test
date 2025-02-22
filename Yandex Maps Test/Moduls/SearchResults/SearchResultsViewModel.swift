//
//  SearchResultsViewModel.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import YandexMapsMobile
import CoreLocation

class SearchResultsViewModel {
    private weak var coordinator: LocationCoordinator?
    private let searchManager = YMKSearch.sharedInstance().createSearchManager(with: .combined)
    
    private var searchSession: YMKSearchSession?
    private(set) var results: [SearchResult] = []
    
    var onResultsUpdated: (() -> Void)?
    
    var onSavedLocationsUpdated: (([SaveSearchLocation]) -> Void)?
    private(set) var saveSearchLocations: [SaveSearchLocation] = [] {
        didSet { onSavedLocationsUpdated?(saveSearchLocations) }
    }
    
    init(coordinator: LocationCoordinator?) {
        self.coordinator = coordinator
    }
    
    func performSearch(query: String) {
        guard !query.isEmpty else {
            results.removeAll()
            onResultsUpdated?()
            return
        }
        
        let searchOptions = YMKSearchOptions()
        searchOptions.resultPageSize = 10
        
        let tashkentBoundingBox = YMKBoundingBox(
            southWest: YMKPoint(latitude: 41.1882, longitude: 69.1150),
            northEast: YMKPoint(latitude: 41.4000, longitude: 69.4000)
        )
        
        searchSession = searchManager.submit(
            withText: query,
            geometry: YMKGeometry(boundingBox: tashkentBoundingBox),
            searchOptions: searchOptions,
            responseHandler: { [weak self] response, error in
                guard let self = self else { return }
                
                if let response = response {
                    self.results = response.collection.children.compactMap { geoObject in
                        guard let point = geoObject.obj?.geometry.first?.point else { return nil }
                        
                        let distance = DistanceCalculator.calculateDistance(to: point)
                        
                        return SearchResult(
                            name: geoObject.obj?.name ?? "Noma'lum joy",
                            address: geoObject.obj?.descriptionText ?? "Manzil mavjud emas",
                            latitude: point.latitude,
                            longitude: point.longitude,
                            distance: distance
                        )
                    }
                    DispatchQueue.main.async {
                        self.onResultsUpdated?()
                    }
                } else {
                    print("Search error: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        )
    }
  
    func presentSearchResultDetail(searchResult: SearchResult) {
        coordinator?.presentSearchResultDetail(searchResult: searchResult)
    }
    
    
    func saveLocation(_ searchResult: SearchResult) {
        SearchLocationManager.shared.saveLocation(data: searchResult)
    }
    
    func fetchSavedLocations() {
        let result = SearchLocationManager.shared.fetchLocations()
        
        switch result {
        case .success(let locations):
            DispatchQueue.main.async { [weak self] in
                self?.saveSearchLocations = locations
            }
        case .failure(let error):
            print("Failed to fetch saved locations: \(error.localizedDescription)")
        }
    }
    
    func deleteLocation(at index: Int) {
        guard index < saveSearchLocations.count else { return }
        let location = saveSearchLocations[index]
        
        SearchLocationManager.shared.deleteLocation(location) { [weak self] in
            DispatchQueue.main.async {
                self?.saveSearchLocations.remove(at: index)
            }
        }
    }
}


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
