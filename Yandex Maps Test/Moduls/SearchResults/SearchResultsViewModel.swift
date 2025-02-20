//
//  SearchResultsViewModel.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

class SearchResultsViewModel {
    private weak var coordinator: LocationCoordinator?
    
    init(coordinator: LocationCoordinator?) {
        self.coordinator = coordinator
    }
    
    func presentSearchResultDetail(searchResult: SearchResult) {
        coordinator?.presentSearchResultDetail(searchResult: searchResult)
    }
}
