//
//  EmptyCell.swift
//  Sportify
//
//  Created by Ali_Kotb on 04/06/2025.
//

import UIKit
import Lottie

class EmptyCell: UITableViewCell {

    @IBOutlet weak var animation: LottieAnimationView!
    override func awakeFromNib() {
        super.awakeFromNib()
        animation.animationSpeed = 0.5
        animation.play()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
