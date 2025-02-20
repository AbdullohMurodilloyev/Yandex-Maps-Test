//
//  SearchView.swift
//  Yandex Maps Test
//
//  Created by Abdulloh Murodilloyev on 19/02/25.
//

import UIKit

class SearchView: UIView {
    
    // MARK: - UI Components
    private let searchIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_search"))
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Поиск"
        textField.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        textField.textColor = .black
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 0.882971704, green: 0.8829715848, blue: 0.882971704, alpha: 1)
        return view
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        layer.cornerRadius = 16
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        layer.applyShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    private func setupView() {
        addSubview(containerView)
        containerView.addSubview(searchIcon)
        containerView.addSubview(textField)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            searchIcon.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            searchIcon.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            searchIcon.widthAnchor.constraint(equalToConstant: 24),
            searchIcon.heightAnchor.constraint(equalToConstant: 24),
            
            textField.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            textField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
        ])
    }
    
    func setTextFieldInteraction(enabled: Bool) {
        textField.isUserInteractionEnabled = enabled
    }
}
