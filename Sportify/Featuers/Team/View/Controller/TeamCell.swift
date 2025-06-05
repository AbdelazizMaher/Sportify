//
//  TeamCell.swift
//  Sportify
//
//  Created by Ali_Kotb on 31/05/2025.
//

import UIKit
import ImageIO

class TeamCell: UITableViewCell {

    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var clubImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        backImg.alpha = 0.85
        
        
        backImg.layer.cornerRadius = 16
         backImg.clipsToBounds = true

        
        backImg.loadGif(named: "stad")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    override func layoutSubviews() {
        super.layoutSubviews()
        
        clubImg.layoutIfNeeded()

      
        clubImg.layer.cornerRadius = clubImg.frame.width / 2
        clubImg.clipsToBounds = true

        clubImg.backgroundColor = UIColor(red: 0.96, green: 0.93, blue: 0.82, alpha: 1.0) // creamy color
    }



}


