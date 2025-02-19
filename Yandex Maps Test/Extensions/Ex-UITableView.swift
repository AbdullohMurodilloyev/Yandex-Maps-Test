//
//  Ex-UITableView.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(cellClass: T.Type = T.self) {
        
        let bundle = Bundle(for: cellClass.self)
        
        if bundle.path(forResource: cellClass.reuseID, ofType: "nib") != nil {
            let nib = UINib(nibName: cellClass.reuseID, bundle: bundle)
            register(nib, forCellReuseIdentifier: cellClass.reuseID)
        } else {
            register(cellClass.self, forCellReuseIdentifier: cellClass.reuseID)
        }
    }
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseID, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseID)")
        }
        return cell
    }
}
