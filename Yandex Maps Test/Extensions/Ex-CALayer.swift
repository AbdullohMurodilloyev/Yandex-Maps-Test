//
//  Ex-CALayer.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import UIKit

extension CALayer {
    func applyShadow() {
        masksToBounds = false
        shadowColor = UIColor.black.withAlphaComponent(0.05).cgColor
        shadowOpacity = 1
        shadowRadius = 10
        shadowOffset = CGSize(width: 0, height: -5)
    }
}
