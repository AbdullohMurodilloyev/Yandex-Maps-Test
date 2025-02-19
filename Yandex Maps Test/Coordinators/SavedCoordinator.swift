//
//  SavedCoordinator.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import UIKit

final class SavedCoordinator: Coordinator {
    
    internal var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vm = SavedViewModel(coordinator: self)
        let vc = SavedViewController(viewModel: vm)
        vc.tabBarItem.image = UIImage(named: "bookMark")
        vc.navigationItem.title = "Мои адреса"
        navigationController.viewControllers = [vc]
    }
    
    
}
