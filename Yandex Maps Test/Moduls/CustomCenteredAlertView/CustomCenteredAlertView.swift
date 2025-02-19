//
//  FavoriteAddressAlertView.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 20/02/25.
//

import UIKit

class CustomCenteredAlertView: Uiview {
    
    // MARK: - UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.applyShadow()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let editButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "editPencil")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9562537074, green: 0.9562535882, blue: 0.9562537074, alpha: 1)
        return view
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.titleLabel?.textAlignment = .center
        button.setTitle("Отмена", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.titleLabel?.textAlignment = .center
        button.setTitle("Подтвердить", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Properties
    var onCancel: (() -> Void)?
    var onConfirm: (() -> Void)?
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    func configure(title: String, message: String) {
        titleLabel.text = title
        messageLabel.text = message
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        backgroundColor = .clear // Start with clear background
        
        let ratingStack = UIStackView(arrangedSubviews: [messageLabel, editButton])
        ratingStack.axis = .horizontal
        ratingStack.spacing = 6
        ratingStack.distribution = .equalSpacing
        
        let buttonStack = UIStackView(arrangedSubviews: [cancelButton, confirmButton])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 5
        buttonStack.alignment = .center
        buttonStack.distribution = .fillEqually
        
        let bottomStack = UIStackView(arrangedSubviews: [ratingStack, lineView, buttonStack])
        bottomStack.axis = .vertical
        bottomStack.spacing = 12
        bottomStack.distribution = .equalSpacing
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        
        let containerStack = UIStackView(arrangedSubviews: [titleLabel, bottomStack])
        containerStack.axis = .vertical
        containerStack.spacing = 24
        containerStack.distribution = .equalSpacing
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(containerView)
        containerView.addSubview(containerStack)
        
        lineView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200),
            
            containerStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            containerStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            containerStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            containerStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
            
        ])
    }
    
    private func setupActions() {
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Button Actions
    @objc private func cancelButtonTapped() {
        onCancel?()
        animateContainerClosing()
    }
    
    @objc private func confirmButtonTapped() {
        onConfirm?()
        animateContainerClosing()
    }
    
    // MARK: - Animation Methods
    private func animateContainerOpening() {
        containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        containerView.alpha = 0.0
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
            self.containerView.transform = .identity
            self.containerView.alpha = 1.0
            self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
    }
    
    
    /// Animates the containerView closing
    private func animateContainerClosing() {
        UIView.animate(withDuration: 0.3, animations: {
            self.containerView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0) // Shrink to small size
            self.containerView.alpha = 0.0 // Fade out container view
            self.backgroundColor = UIColor.clear // Fade out background
        }) { _ in
            self.removeFromSuperview() // Remove the view from its superview
        }
    }
    
    // MARK: - Show/Hide Methods
    func show(in view: UIView) {
        frame = view.bounds
        view.addSubview(self)
        
        // Initial state setup before animation
        containerView.alpha = 1.0
        backgroundColor = UIColor.clear
        
        // Run opening animation
        animateContainerOpening()
    }
}
