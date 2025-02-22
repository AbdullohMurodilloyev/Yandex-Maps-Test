//
//  LocationCoordinator.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import UIKit

final class LocationCoordinator: Coordinator {
    
    internal var navigationController: UINavigationController
    weak var parentCoordinator: TabbarCoordinator?
    
    init(navigationController: UINavigationController, parentCoordinator: TabbarCoordinator?) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start(searchResult: SearchResult? = nil) {
        let vm = LocationViewModel(coordinator: self, searchResult: searchResult)
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
        navigationController.topViewController?.present(vc, animated: true)
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
        navigationController.topViewController?.present(vc, animated: true)
    }
    
    func presentAlert(searchResult: SearchResult) {
        let vm = CustomCenteredAlertViewModel(coordinator: self)
        let vc = CustomCenteredAlertViewController(viewModel: vm, searchResult: searchResult)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        navigationController.topViewController?.present(vc, animated: true)
    }
    
    func goToLocationScreen() {
        parentCoordinator?.switchToCoordinator()
    }
}
