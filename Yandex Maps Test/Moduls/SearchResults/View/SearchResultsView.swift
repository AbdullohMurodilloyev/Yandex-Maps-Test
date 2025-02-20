//
//  SearchResultsView.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import UIKit
import YandexMapsMobile
import CoreLocation

protocol SearchResultsViewDelegate: AnyObject {
    func tappedCell(result: SearchResult)
}

class SearchResultsView: UIView {
    
    private let searchView = SearchView()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(cellClass: SearchResultCell.self)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .singleLine
        table.contentInset.top = 10
        return table
    }()
    
    weak var delegate: SearchResultsViewDelegate?
    
    let searchManager = YMKSearch.sharedInstance().createSearchManager(with: .combined)
    private var searchSession: YMKSearchSession?
    private var results: [YMKGeoObject] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        searchView.setTextFieldInteraction(enabled: true)
        searchView.textField.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 16
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.masksToBounds = true
        
        addSubview(searchView)
        addSubview(tableView)
        
        searchView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: topAnchor, constant: 26),
            searchView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            searchView.heightAnchor.constraint(equalToConstant: 64),
            
            tableView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Search Logic
    @objc private func searchTextChanged() {
        guard let query = searchView.textField.text, !query.isEmpty else {
            results.removeAll()
            tableView.reloadData()
            return
        }
        performSearch(query: query)
    }
    
    
    private func performSearch(query: String) {
        let searchOptions = YMKSearchOptions()
        searchOptions.resultPageSize = 10

        // Toshkent shahri bounding box
        let tashkentBoundingBox = YMKBoundingBox(
            southWest: YMKPoint(latitude: 41.1882, longitude: 69.1150),
            northEast: YMKPoint(latitude: 41.4000, longitude: 69.4000)
        )

        searchSession = searchManager.submit(
            withText: query,
            geometry: YMKGeometry(boundingBox: tashkentBoundingBox),
            searchOptions: searchOptions,
            responseHandler: { [weak self] response, error in
                guard let self = self else { return }
                
                if let response = response {
                    self.results = response.collection.children.compactMap { $0.obj }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    print("Search error: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        )
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension SearchResultsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchResultCell = tableView.dequeueReusableCell(for: indexPath)
        let result = results[indexPath.row]
        
        // Get the name or use a default
        let name = result.name ?? "Unnamed location"
        
        // Extract address or description for subtitle
        let subtitle = result.descriptionText ?? result.metadataContainer.description
        
        let distanceText: String
        if let point = result.geometry.first?.point {
            distanceText = calculateDistance(to: point)
        } else {
            distanceText = "Masofa mavjud emas"
        }
        
        cell.configure(with: name, subtitle: subtitle, distance: distanceText)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedResult = results[indexPath.row]
        
        // Geo koordinatalarni olish
        guard let point = selectedResult.geometry.first?.point else {
            print("Koordinatalar topilmadi")
            return
        }
        
        let data = SearchResult(
            name: selectedResult.name ?? "Noma'lum joy",
            address: selectedResult.descriptionText ?? "Manzil mavjud emas",
            latitude: point.latitude,
            longitude: point.longitude
        )
        
        delegate?.tappedCell(result: data)
    }
    
    private func calculateDistance(to point: YMKPoint) -> String {
        let tashkentLocation = CLLocation(latitude: 41.364521, longitude: 69.281377)
        
        let resultLocation = CLLocation(latitude: point.latitude, longitude: point.longitude)
        let distanceInMeters = tashkentLocation.distance(from: resultLocation)
        
        if distanceInMeters < 1000 {
            return String(format: "%.0f m", distanceInMeters)
        } else {
            return String(format: "%.1f km", distanceInMeters / 1000)
        }
    }
    
}
