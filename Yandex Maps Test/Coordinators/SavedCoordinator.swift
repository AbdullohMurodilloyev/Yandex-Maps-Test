//
//  SavedCoordinator.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import UIKit

final class SavedCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    weak var parentCoordinator: TabbarCoordinator?  
    
    init(navigationController: UINavigationController, parentCoordinator: TabbarCoordinator?) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let vm = SavedViewModel(coordinator: self)
        let vc = SavedViewController(viewModel: vm)
        vc.tabBarItem.image = UIImage(named: "bookMark")
        vc.navigationItem.title = "Мои адреса"
        navigationController.viewControllers = [vc]
    }
    
    func goToLocationScreen(data: SearchResult) {
        parentCoordinator?.switchToCoordinator(select: 1, data: data)
    }
}
