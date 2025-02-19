//
//  SavedTableVIewCell.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import UIKit

class SavedTableVIewCell: UITableViewCell {
    
    // UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Le Grande Plaza Hotel"
        label.textColor = .black
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "ул. Узбекистон Овози, 2"
        label.textColor = .lightGray
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "locationFavourite")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.applyShadow()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Stack Views
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var containerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [labelStack, iconImageView])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(containerStack)
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            containerStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            containerStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            containerStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            containerStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            iconImageView.widthAnchor.constraint(equalToConstant: 32),
            iconImageView.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}
