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
    
    
}
