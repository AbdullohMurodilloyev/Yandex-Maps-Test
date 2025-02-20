//
//  SearchResultCell.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//
import UIKit

class SearchResultCell: UITableViewCell {
    
    // UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .lightGray
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "location")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    // Stack Views
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [topStack, subtitleLabel])
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    private lazy var topStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, distanceLabel])
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var containerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iconImageView, labelStack])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .fill
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
        contentView.addSubview(containerStack)
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            containerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            iconImageView.widthAnchor.constraint(equalToConstant: 32),
            iconImageView.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    func configure(with title: String, subtitle: String, distance: String ) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        distanceLabel.text = distance
    }
}
