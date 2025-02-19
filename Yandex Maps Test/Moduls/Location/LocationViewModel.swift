//
//  LocationViewModel.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import Foundation

class LocationViewModel {
    private weak var coordinator: LocationCoordinator?
    
    init(coordinator: LocationCoordinator?) {
        self.coordinator = coordinator
    }
    
    func pushToSearchResults() {
        coordinator?.pushToSearchResults()
    }
}

