//
//  SearchResultsViewController.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import UIKit
import YandexMapsMobile

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
        setupBindings()
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
        
        searchResultsView.searchView.textField.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
    }
    
    private func setupBindings() {
        viewModel.onResultsUpdated = { [weak self] in
            self?.searchResultsView.results = self?.viewModel.results ?? []
        }
    }

    @objc private func searchTextChanged() {
        if let query = searchResultsView.searchView.textField.text {
            viewModel.performSearch(query: query)
        }
    }
}

extension SearchResultsViewController: SearchResultsViewDelegate {
    func tappedCell(result: SearchResult) {
        delegate?.didSelectSearchResult(result)
        dismiss(animated: true) { [weak self] in
            self?.viewModel.presentSearchResultDetail(searchResult: result)
        }
    }
}
