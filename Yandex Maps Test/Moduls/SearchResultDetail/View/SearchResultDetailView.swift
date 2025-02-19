//
//  SearchResultDetailView.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 20/02/25.
//

import UIKit

protocol SearchResultDetailViewDelegate: AnyObject {
    func tappedFavoriteAddressAlert()
}

class SearchResultDetailView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = "Le Grande Plaza Hotel"
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .gray
        label.text = "Ташкент, ул. Узбекистон Овози, 2"
        return label
    }()
    
    private let ratingStarsView = UIStackView()
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = "517 оценок"
        label.textColor = .gray
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить в избранное", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3568627451, green: 0.7607843137, blue: 0.3137254902, alpha: 1)
        button.layer.cornerRadius = 21
        button.addTarget(self, action: #selector(showFavoriteAddressAlert), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: SearchResultDetailViewDelegate?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        
        ratingStarsView.axis = .horizontal
        ratingStarsView.spacing = 4
        addStars(count: 4)
        
        let ratingStack = UIStackView(arrangedSubviews: [ratingStarsView, ratingLabel])
        ratingStack.axis = .horizontal
        ratingStack.spacing = 6
        
        let labelStackView = UIStackView(arrangedSubviews: [titleLabel, addressLabel])
        labelStackView.axis = .vertical
        labelStackView.spacing = 5
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [labelStackView, ratingStack])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        addSubview(favoriteButton)
        
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: favoriteButton.topAnchor, constant: -12),
            
            favoriteButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            favoriteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -41),
            favoriteButton.heightAnchor.constraint(equalToConstant: 42),
            favoriteButton.widthAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    private func addStars(count: Int) {
        for _ in 0..<5 {
            let star = UIImageView(image: UIImage(systemName: "star.fill"))
            star.tintColor = #colorLiteral(red: 0.7882352941, green: 0.8901960784, blue: 0.1215686275, alpha: 1)
            star.widthAnchor.constraint(equalToConstant: 16).isActive = true
            star.heightAnchor.constraint(equalToConstant: 16).isActive = true
            ratingStarsView.addArrangedSubview(star)
        }
    }
    
    func configure(with hotelName: String, address: String, rating: Int, reviews: Int) {
        titleLabel.text = hotelName
        addressLabel.text = address
        ratingLabel.text = "\(reviews) оценок"
        addStars(count: rating)
    }
    
    @objc func showFavoriteAddressAlert() {       
        delegate?.tappedFavoriteAddressAlert()
    }

}
