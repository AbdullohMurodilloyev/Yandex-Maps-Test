//
//  SearchResultsViewController.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func didSelectSearchResult(_ result: SearchResult)
}

class SearchResultsViewController: UIViewController {
    
    weak var delegate: SearchResultsViewControllerDelegate?
    private let searchResultsView = SearchResultsView()
    private let viewModel: SearchResultsViewModel
    
    init(viewModel: SearchResultsViewModel, delegate: SearchResultsViewControllerDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
        viewModel.fetchSavedLocations()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(searchResultsView)
        searchResultsView.delegate = self
        
        searchResultsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchResultsView.topAnchor.constraint(equalTo: view.topAnchor),
            searchResultsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchResultsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchResultsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.onResultsUpdated = { [weak self] in
            self?.searchResultsView.results = self?.viewModel.results ?? []
        }
        
        viewModel.onSavedLocationsUpdated = { [weak self] locations in
            self?.searchResultsView.results = locations.map {
                SearchResult(name: $0.name ?? "",
                             address: $0.address ?? "",
                             latitude: $0.latitude,
                             longitude: $0.longitude,
                             distance: $0.distance ?? "")
            }
        }
    }
}

extension SearchResultsViewController: SearchResultsViewDelegate {
    func didTapCell(result: SearchResult) {
        delegate?.didSelectSearchResult(result)
        dismiss(animated: true) { [weak self] in
            self?.viewModel.saveLocation(result)
        }
    }
    
    func didRequestDeleteLocation(at index: Int) {
        viewModel.deleteLocation(at: index)
    }
    
    func didChangeSearchQuery(_ query: String) {
        searchResultsView.isSearching = !query.isEmpty
        query.isEmpty ? viewModel.fetchSavedLocations() : viewModel.performSearch(query: query)
    }
}
