//
//  SearchResultDetailViewController.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 20/02/25.
//

import UIKit

class SearchResultDetailViewController: UIViewController {
    
    // MARK: - Properties
    private let detailView = SearchResultDetailView()
    private let viewModel: SearchResultDetailViewModel
    private let searchResult: SearchResult
    
    // MARK: - Init
    init(viewModel: SearchResultDetailViewModel, searchResult: SearchResult) {
        self.viewModel = viewModel
        self.searchResult = searchResult
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configure(with: searchResult.name, address: searchResult.address)
    }
    
    private func setupView() {
        view.addSubview(detailView)
        detailView.delegate = self
        
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func configure(with hotelName: String, address: String) {
        detailView.configure(with: hotelName, address: address)
    }
    
}

// MARK: Delegate
extension SearchResultDetailViewController: SearchResultDetailViewDelegate {
    func tappedFavoriteAddressAlert() {
        dismiss(animated: true) { [weak self] in
            if let data = self?.searchResult {
                self?.viewModel.presentAlert(searchResult: data)
            }
        }
    }
}
