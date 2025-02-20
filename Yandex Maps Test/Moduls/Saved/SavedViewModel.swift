//
//  SavedViewModel.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import Foundation

class SavedViewModel {
    private weak var coordinator: SavedCoordinator?
    
    init(coordinator: SavedCoordinator?) {
        self.coordinator = coordinator
    }
    
    var savedLocations: [SavedLocation] = [] {
        didSet {
            onSavedLocationsUpdated?(savedLocations)
        }
    }
    
    var onSavedLocationsUpdated: (([SavedLocation]) -> Void)?
    
    func fetchSavedLocations() {
        let result = DataBaseHelper.shared.fetchLocations()
        
        switch result {
        case .success(let locations):
            self.savedLocations = locations
        case .failure(let error):
            print("Failed to fetch saved locations: \(error.localizedDescription)")
        }
    }
    
    func deleteLocation(at index: Int) {
        guard index < savedLocations.count else { return }
        let location = savedLocations[index]

        DataBaseHelper.shared.deleteLocation(location) { [weak self] in
            self?.savedLocations.remove(at: index)
        }
    }
}
