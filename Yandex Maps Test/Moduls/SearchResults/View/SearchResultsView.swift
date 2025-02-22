//
//  SearchResultsView.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import UIKit

protocol SearchResultsViewDelegate: AnyObject {
    func didTapCell(result: SearchResult)
    func didRequestDeleteLocation(at index: Int)
    func didChangeSearchQuery(_ query: String)
}

class SearchResultsView: UIView {
    
    weak var delegate: SearchResultsViewDelegate?
    
    private let searchView = SearchView()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(cellClass: SearchResultCell.self)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .singleLine
        table.contentInset.top = 10
        table.dataSource = self
        table.delegate = self
        return table
    }()

    
    var results: [SearchResult] = [] {
        didSet { tableView.reloadData() }
    }
    
    var isSearching = false {
        didSet { tableView.setEditing(!isSearching, animated: true) }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
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
    
    @objc private func searchTextChanged() {
        delegate?.didChangeSearchQuery(searchView.textField.text ?? "")
    }
}

extension SearchResultsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchResultCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: results[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didTapCell(result: results[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return !isSearching
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delegate?.didRequestDeleteLocation(at: indexPath.row)
        }
    }
}
