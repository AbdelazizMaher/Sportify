//
//  HomeCollectionViewCell.swift
//  Sportify
//
//  Created by Abdelaziz on 31/05/2025.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var sportTypeTxt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.masksToBounds = false

        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        sportTypeTxt.font = UIFont.boldSystemFont(ofSize: 24)
        sportTypeTxt.textAlignment = .center
        sportTypeTxt.textColor = .white
        sportTypeTxt.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        sportTypeTxt.layer.cornerRadius = 0
    }

}
