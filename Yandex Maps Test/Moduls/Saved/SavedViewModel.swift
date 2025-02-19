//
//  SavedViewModel.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import Foundation

class SavedViewModel {
    private weak var coordinator: SavedCoordinator?
    
    init(coordinator: SavedCoordinator?) {
        self.coordinator = coordinator
    }
}
