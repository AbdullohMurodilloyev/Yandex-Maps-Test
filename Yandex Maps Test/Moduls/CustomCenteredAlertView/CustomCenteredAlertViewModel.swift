//
//  CustomCenteredAlertViewModel.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 20/02/25.
//

class CustomCenteredAlertViewModel {
    private weak var coordinator: LocationCoordinator?
    
    init(coordinator: LocationCoordinator?) {
        self.coordinator = coordinator
    }
    
    func saveLocation(_ searchResult: SearchResult) {
        DataBaseHelper.shared.saveLocation(data: searchResult)
    }
    
    func goToLocation() {
        coordinator?.goToLocationScreen()
    }
}
