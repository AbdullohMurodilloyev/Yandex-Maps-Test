//
//  SavedViewController.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import UIKit

class SavedViewController: UIViewController {
    
    private let viewModel: SavedViewModel
    private let savedView = SavedView()
    
    init(viewModel: SavedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
        viewModel.fetchSavedLocations()
    }
    
    private func setupView() {
        view.addSubview(savedView)
        savedView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            savedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            savedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            savedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            savedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        savedView.onDeleteLocation = { [weak self] index in
            self?.deleteLocation(at: index)
        }
    }
    
    private func setupBindings() {
        viewModel.onSavedLocationsUpdated = { [weak self] locations in
            self?.savedView.results = locations.map {
                SearchResult(name: $0.name ?? "",
                             address: $0.address ?? "",
                             latitude: $0.latitude,
                             longitude: $0.longitude,
                             distance: "") }
        }
    }
    
    private func deleteLocation(at index: Int) {
        viewModel.deleteLocation(at: index)
    }
}
