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
    private lazy var locationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "currentLocation"), for: .normal)
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(currentLocationTapped), for: .touchUpInside)
        return button
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
        setupView()
        setUpMapMethods()
        searchView.setTextFieldInteraction(enabled: false)
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showSearch))
        searchView.addGestureRecognizer(tapGesture)
    }
    
    private func setUpMapMethods() {
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(
                target: YMKPoint(latitude: 41.2995, longitude: 69.2401),
                zoom: 11,
                azimuth: 0,
                tilt: 30.0
            ),
            animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 1),
            cameraCallback: nil)
    }
}

// MARK: - Setup Methods
extension LocationViewController {
    private func setupView() {
        view.addSubview(mapView)
        view.addSubview(searchView)
        view.addSubview(locationButton)
        
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


// MARK: - Actions
extension LocationViewController {
    @objc private func currentLocationTapped() {
        print("📍 Current location button tapped")
        moveToUserLocation()
    }
    
    private func moveToUserLocation() {
        // Foydalanuvchi lokatsiyasini olish (o'zingizning CLLocationManager implementatsiyangizni qo'shing)
        let userLatitude: Double = 41.2995
        let userLongitude: Double = 69.2401
        
        let userLocation = YMKPoint(latitude: userLatitude, longitude: userLongitude)
        
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(target: userLocation, zoom: 14, azimuth: 0, tilt: 30.0),
            animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 1),
            cameraCallback: nil
        )
    }
    
    @objc private func showSearch() {
        viewModel.pushToSearchResults()
    }
}
