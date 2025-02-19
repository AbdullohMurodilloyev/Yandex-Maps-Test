//
//  TabbarController.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import UIKit

class TabbarController: UITabBarController {
    
    // MARK: - Coordinators
    private let savedCoordinator = SavedCoordinator(navigationController: UINavigationController())
    private let locationCoordinator = LocationCoordinator(navigationController: UINavigationController())
  
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCoordinators()
        setupTabBar()
    }
    
    // MARK: - Setup Methods
    private func setupCoordinators() {
        savedCoordinator.start()
        locationCoordinator.start()
        viewControllers = [
            savedCoordinator.navigationController,
            locationCoordinator.navigationController
        ]
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = UIColor.lightGray
        tabBar.layer.cornerRadius = 8
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.applyShadow()
    }
}

