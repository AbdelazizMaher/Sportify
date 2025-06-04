//
//  OnBoardingSlidesViewController.swift
//  Sportify
//
//  Created by Abdelaziz on 04/06/2025.
//

import UIKit

class OnBoardingSlidesViewController: UIViewController {

    var imageName: String?
    var labelText: String?
    var labelPosition: NSLayoutConstraint.Attribute = .bottom
    
    private let imageView = UIImageView()
    private let label = UILabel()
    private let shadowView = UIView()
    
    init(imageName: String, labelText: String, labelPosition: NSLayoutConstraint.Attribute) {
        self.imageName = imageName
        self.labelText = labelText
        self.labelPosition = labelPosition
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setupImageView()
        setupLabelWithShadow()
    }
    
    private func setupImageView() {
        imageView.image = UIImage(named: imageName ?? "")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setupLabelWithShadow() {
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shadowView)
        
        label.text = labelText
        label.textColor = .white
        label.font = UIFont(name: "Impact", size: 24) ?? UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        shadowView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: shadowView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: -8),
            label.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -16)
        ])
        
        shadowView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        shadowView.layer.cornerRadius = 12
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowRadius = 8
        shadowView.layer.shadowOpacity = 0.8
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        switch labelPosition {
        case .top:
            NSLayoutConstraint.activate([
                shadowView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                shadowView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                shadowView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.7)
            ])
        case .bottom:
            NSLayoutConstraint.activate([
                shadowView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
                shadowView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                shadowView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.9)
            ])
        default:
            NSLayoutConstraint.activate([
                shadowView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                shadowView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                shadowView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.9)
            ])
        }
    }
}
