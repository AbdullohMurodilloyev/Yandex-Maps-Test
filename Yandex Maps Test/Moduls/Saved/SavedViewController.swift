//
//  SavedViewController.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import UIKit

class SavedViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: SavedViewModel
    private let savedView = SavedView()
    
    // MARK: - Init
    init(viewModel: SavedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchSavedLocations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchSavedLocations()
    }
    
    private func setupUI() {
        view.addSubview(savedView)
        savedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            savedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            savedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            savedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            savedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        savedView.delegate = self
    }
    
    private func bindViewModel() {
        viewModel.onSavedLocationsUpdated = { [weak self] locations in
            self?.savedView.results = locations.map {
                SearchResult(
                    name: $0.name ?? "",
                    address: $0.address ?? "",
                    latitude: $0.latitude,
                    longitude: $0.longitude,
                    distance: ""
                )
            }
        }
    }
}

// MARK: - SavedViewDelegate
extension SavedViewController: SavedViewDelegate {
    func didTapCell(result: SearchResult) {
        viewModel.goToLocation(data: result)
    }
    
    func didDeleteLocation(at index: Int) {
        viewModel.deleteLocation(at: index)
    }
}
