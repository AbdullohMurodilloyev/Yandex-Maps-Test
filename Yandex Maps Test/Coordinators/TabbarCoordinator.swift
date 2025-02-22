//
//  TabbarCoordinator.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 22/02/25.
//

import UIKit

final class TabbarCoordinator {
    lazy var tabBarController: TabbarController = {
        return TabbarController(tabBarCoordinator: self)
    }()
    
    private lazy var savedCoordinator: SavedCoordinator = {
        let savedNavController = UINavigationController()
        return SavedCoordinator(navigationController: savedNavController, parentCoordinator: self)
    }()
    
    private lazy var locationCoordinator: LocationCoordinator = {
        let locationNavController = UINavigationController()
        return LocationCoordinator(navigationController: locationNavController, parentCoordinator: self)
    }()
    
    init() {}
    
    func start() {
        savedCoordinator.start()
        locationCoordinator.start()
        
        tabBarController.viewControllers = [
            savedCoordinator.navigationController,
            locationCoordinator.navigationController
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
