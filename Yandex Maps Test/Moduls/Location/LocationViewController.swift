//
//  LocationViewController.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import UIKit
import YandexMapsMobile

class LocationViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: LocationViewModel
    private let mapView = YMKMapView()
    private let searchView = SearchView()
    private let locationButton = UIButton()
    
    // MARK: - Init
    init(viewModel: LocationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupMap()
        bindViewModel()
        
    }
    
    private func bindViewModel() {
        viewModel.onDrag = { [weak self] point in
            self?.moveCamera(to: point)
        }
        if let searchResult = viewModel.searchResult {
            viewModel.moveToLocation(latitude: searchResult.latitude,
                                     longitude: searchResult.longitude, on: mapView)
        }
    }
    
    private func moveCamera(to point: YMKPoint) {
        viewModel.moveMap(to: point, zoom: 15, on: mapView)
    }
}

// MARK: - UI Setup
private extension LocationViewController {
    func setupView() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(mapView)
        view.addSubview(searchView)
        view.addSubview(locationButton)
        
        setupSearchView()
        setupLocationButton()
        setupConstraints()
    }
    
    func setupSearchView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showSearch))
        searchView.addGestureRecognizer(tapGesture)
        searchView.setTextFieldInteraction(enabled: false)
    }
    
    func setupLocationButton() {
        locationButton.setImage(UIImage(named: "currentLocation"), for: .normal)
        locationButton.adjustsImageWhenHighlighted = false
        locationButton.addTarget(self, action: #selector(currentLocationTapped), for: .touchUpInside)
    }
    
    func setupConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        searchView.translatesAutoresizingMaskIntoConstraints = false
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchView.heightAnchor.constraint(equalToConstant: 64),
            
            locationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            locationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            locationButton.widthAnchor.constraint(equalToConstant: 64),
            locationButton.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
}

// MARK: - Map Setup
private extension LocationViewController {
    func setupMap() {
        viewModel.moveToInitialLocation(on: mapView)
    }
}

// MARK: - Actions
private extension LocationViewController {
    @objc func currentLocationTapped() {
        viewModel.moveToUserLocation(on: mapView)
    }
    
    @objc func showSearch() {
        viewModel.pushToSearchResults(delegate: self)
    }
}

// MARK: - SearchResultsViewControllerDelegate
extension LocationViewController: SearchResultsViewControllerDelegate {
    func didSelectSearchResult(_ result: SearchResult) {
        viewModel.moveToLocation(latitude: result.latitude, longitude: result.longitude, on: mapView)
    }
}
