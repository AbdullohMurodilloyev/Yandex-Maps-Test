//
//  TabbarCoordinator.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 22/02/25.
//

import UIKit

final class TabbarCoordinator: BaseCoordinator {
    
    private lazy var savedCoordinator: SavedCoordinator = {
        let coordinator = SavedCoordinator()
        coordinator.navigationController = UINavigationController()
        coordinator.parentCoordinator = self
        add(childCoordinator: coordinator)
        return coordinator
    }()
    
    private lazy var locationCoordinator: LocationCoordinator = {
        let coordinator = LocationCoordinator()
        coordinator.navigationController = UINavigationController()
        coordinator.parentCoordinator = self
        add(childCoordinator: coordinator)
        return coordinator
    }()
    
    lazy var tabBarController: TabbarController = {
        return TabbarController(tabBarCoordinator: self)
    }()
    
    override func start() {
        savedCoordinator.start()

        locationCoordinator.start()
        
        tabBarController.viewControllers = [
            savedCoordinator.navigationController!,
            locationCoordinator.navigationController!
        ]
    }

    func switchToCoordinator(select: Int = 0, data: Any? = nil) {
        tabBarController.selectedIndex = select
        if select == 1 {
            let searchResult = data as? SearchResult
            locationCoordinator.start(searchResult: searchResult)
        }
    }
}
