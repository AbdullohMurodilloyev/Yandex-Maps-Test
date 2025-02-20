//
//  SearchResultDetailViewModel.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 20/02/25.
//

class SearchResultDetailViewModel {
    private weak var coordinator: LocationCoordinator?
    
    init(coordinator: LocationCoordinator?) {
        self.coordinator = coordinator
    }
    
    func presentAlert() {
        coordinator?.presentAlert()
    }
}
