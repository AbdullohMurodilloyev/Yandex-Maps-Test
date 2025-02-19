//
//  CustomCenteredAlertViewController.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 20/02/25.
//

import UIKit

class CustomCenteredAlertViewController: UIViewController {
    
    // MARK: - Properties
    private let alertView = CustomCenteredAlertView()
    private let viewModel: CustomCenteredAlertViewModel
    
    // MARK: - Init
    init(viewModel: CustomCenteredAlertViewModel) {
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
    
    private func setupView() {
        view.backgroundColor = .clear
        view.addSubview(alertView)
        alertView.configure(title: "Добавить адрес в избранное", message: "ул. Узбекистон Овози, 2")
        alertView.show(in: view)
        
        alertView.onCancel = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        alertView.onConfirm = { [weak self] in
            self?.dismiss(animated: true) {
                AppDelegate.shared?.startMainFlow()
            }
        }
    }
}
