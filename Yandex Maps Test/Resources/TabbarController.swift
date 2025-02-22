//
//  TabbarController.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import UIKit

class TabbarController: UITabBarController {
    
    // MARK: - Coordinator
    private let tabBarCoordinator: TabbarCoordinator

    // MARK: - Init
    init(tabBarCoordinator: TabbarCoordinator) {
        self.tabBarCoordinator = tabBarCoordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    // MARK: - Setup Methods
    private func setupTabBar() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = UIColor.lightGray
        tabBar.layer.cornerRadius = 8
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.applyShadow()
    }
}



