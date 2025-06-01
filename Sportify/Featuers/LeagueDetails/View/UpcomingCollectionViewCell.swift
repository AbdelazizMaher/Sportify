//
//  UpcomingCollectionViewCell.swift
//  Sportify
//
//  Created by Abdelaziz on 31/05/2025.
//

import UIKit

class UpcomingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var team1Logo: UIImageView!
    @IBOutlet weak var team2Logo: UIImageView!
    
    @IBOutlet weak var team1Title: UILabel!
    @IBOutlet weak var team2Title: UILabel!
    
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        team1Logo.layer.cornerRadius = team1Logo.frame.size.width / 2
        team1Logo.clipsToBounds = true
        team2Logo.layer.cornerRadius = team2Logo.frame.size.width / 2
        team2Logo.clipsToBounds = true
        
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 6
        layer.masksToBounds = false

        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
    }

}
