//
//  LatestCollectionViewCell.swift
//  Sportify
//
//  Created by Abdelaziz on 31/05/2025.
//

import UIKit

class LatestCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var team1Logo: UIImageView!
    @IBOutlet weak var team2Logo: UIImageView!
    
    @IBOutlet weak var team1Title: UILabel!
    @IBOutlet weak var team2Title: UILabel!
    
    @IBOutlet weak var team1Score: UILabel!
    @IBOutlet weak var team2Score: UILabel!
        
    @IBOutlet weak var eventDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.red.cgColor
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        applyGradientBackground(to: contentView, cornerRadius: 12, style: .defaultCell)
    }

}
