//
//  SearchResultsViewModel.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import YandexMapsMobile

class SearchResultsViewModel {
    private weak var coordinator: LocationCoordinator?
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
        
        LocationSearchManager.shared.searchByText(query) { [weak self] results in
            guard let self = self else { return }
            self.results = results
            DispatchQueue.main.async {
                self.onResultsUpdated?()
            }
        }
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
