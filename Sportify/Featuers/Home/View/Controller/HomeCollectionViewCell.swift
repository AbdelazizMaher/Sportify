//
//  HomeCollectionViewCell.swift
//  Sportify
//
//  Created by Abdelaziz on 31/05/2025.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var sportTypeTxt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupBaseUI()
        startFloatingAnimation()
        addBorderGlow()
    }
    
    private func setupBaseUI() {
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.masksToBounds = false
        
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        sportTypeTxt.font = UIFont(name: "American Typewriter Bold", size: 26)
        sportTypeTxt.textAlignment = .center
        sportTypeTxt.textColor = .white
        sportTypeTxt.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        sportTypeTxt.layer.cornerRadius = 8
    }
    
    private func startFloatingAnimation() {
        let floatAnimation = CABasicAnimation(keyPath: "position.y")
        floatAnimation.fromValue = contentContainerView.center.y
        floatAnimation.toValue = contentContainerView.center.y - 10
        floatAnimation.duration = 2.5
        floatAnimation.autoreverses = true
        floatAnimation.repeatCount = .infinity
        floatAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        contentContainerView.layer.add(floatAnimation, forKey: "floating")
    }
        
    private func addBorderGlow() {
        let borderLayer = CALayer()
        borderLayer.frame = contentContainerView.bounds
        borderLayer.cornerRadius = 12
        borderLayer.borderWidth = 2
        borderLayer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        borderLayer.opacity = 0

        let glowAnimation = CABasicAnimation(keyPath: "opacity")
        glowAnimation.fromValue = 0
        glowAnimation.toValue = 1
        glowAnimation.duration = 1.5
        glowAnimation.autoreverses = true
        glowAnimation.repeatCount = .infinity
        borderLayer.add(glowAnimation, forKey: "glow")

        contentContainerView.layer.addSublayer(borderLayer)
    }

}
	
