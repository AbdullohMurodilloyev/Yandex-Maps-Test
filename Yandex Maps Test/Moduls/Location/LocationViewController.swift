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
    
    private let centerPin: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "pin"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
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
        setupUI()
        setupMap()
        handleInitialSearchResult()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        addSubviews()
        setupSearchView()
        setupLocationButton()
        setupConstraints()
    }
    
    private func addSubviews() {
        [mapView, searchView, locationButton, centerPin].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupSearchView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showSearchTapped))
        searchView.addGestureRecognizer(tapGesture)
        searchView.setTextFieldInteraction(enabled: false)
    }
    
    private func setupLocationButton() {
        locationButton.setImage(UIImage(named: "currentLocation"), for: .normal)
        locationButton.adjustsImageWhenHighlighted = false
        locationButton.addTarget(self, action: #selector(currentLocationTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        [mapView, searchView, locationButton, centerPin].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            // MapView
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // SearchView
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchView.heightAnchor.constraint(equalToConstant: 64),
            
            // LocationButton
            locationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            locationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            locationButton.widthAnchor.constraint(equalToConstant: 64),
            locationButton.heightAnchor.constraint(equalToConstant: 64),
            
            // CenterPin
            centerPin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerPin.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            centerPin.widthAnchor.constraint(equalToConstant: 60),
            centerPin.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupMap() {
        mapView.mapWindow.map.addCameraListener(with: viewModel)
        viewModel.moveToInitialLocation(on: mapView)
    }
    
    private func handleInitialSearchResult() {
        guard let searchResult = viewModel.searchResult else { return }
        viewModel.moveToLocation(
            latitude: searchResult.latitude,
            longitude: searchResult.longitude,
            on: mapView,
            performSearch: true
        )
    }
    
    // MARK: - Actions
    @objc private func currentLocationTapped() {
        viewModel.moveToUserLocation(on: mapView, performSearch: true)
    }
    
    @objc private func showSearchTapped() {
        viewModel.pushToSearchResults(delegate: self)
    }
}

// MARK: - SearchResultsViewControllerDelegate
extension LocationViewController: SearchResultsViewControllerDelegate {
    func didSelectSearchResult(_ result: SearchResult) {
        viewModel.moveToLocation(
            latitude: result.latitude,
            longitude: result.longitude,
            on: mapView,
            performSearch: true
        )
    }
}
