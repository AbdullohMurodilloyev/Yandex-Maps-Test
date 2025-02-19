//
//  SearchResultsViewController.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    // MARK: - Properties
    private let searchResults = SearchResultsView()
    private let viewModel: SearchResultsViewModel
    
    // MARK: - Init
    init(viewModel: SearchResultsViewModel) {
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
    }
    
    // MARK: - Setup
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(searchResults)
        searchResults.delegate = self
        
        searchResults.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchResults.topAnchor.constraint(equalTo: view.topAnchor),
            searchResults.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchResults.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchResults.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension SearchResultsViewController: SearchResultsViewDelegate {
    func tappedCell() {
        dismiss(animated: true) { [weak self] in
            self?.viewModel.presentSearchResultDetail()
        }
    }
}
