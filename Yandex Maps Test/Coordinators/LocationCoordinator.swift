//
//  LocationCoordinator.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import UIKit

final class LocationCoordinator: Coordinator {
    
    internal var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vm = LocationViewModel(coordinator: self)
        let vc = LocationViewController(viewModel: vm)
        vc.tabBarItem.image = UIImage(named: "location")
        navigationController.viewControllers = [vc]
    }
    
    func pushToSearchResults(delegate: SearchResultsViewControllerDelegate) {
        let vm = SearchResultsViewModel(coordinator: self)
        let vc = SearchResultsViewController(viewModel: vm, delegate: delegate)
        vc.modalPresentationStyle = .pageSheet
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        navigationController.present(vc, animated: true)
    }
    
    func presentSearchResultDetail(searchResult: SearchResult) {
        let vm = SearchResultDetailViewModel(coordinator: self)
        let vc = SearchResultDetailViewController(viewModel: vm, searchResult: searchResult)
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.custom { _ in
                return 170
            }]
            sheet.prefersGrabberVisible = true
        }
        navigationController.present(vc, animated: true)
    }
    
    func presentAlert(searchResult: SearchResult) {
        let vm = CustomCenteredAlertViewModel(coordinator: self)
        let vc = CustomCenteredAlertViewController(viewModel: vm, searchResult: searchResult)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        navigationController.present(vc, animated: true)
    }    
    
}
