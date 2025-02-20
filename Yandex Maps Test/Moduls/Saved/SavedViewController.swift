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
        setupView()
        view.backgroundColor = #colorLiteral(red: 0.9813271165, green: 0.9813271165, blue: 0.9813271165, alpha: 1)
    }
    
    
    
    // MARK: - Setup Methods
    private func setupView() {
        view.addSubview(savedView)
        savedView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            savedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            savedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            savedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            savedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    
    
    
}
