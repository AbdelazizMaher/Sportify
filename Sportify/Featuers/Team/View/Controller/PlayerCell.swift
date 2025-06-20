//
//  PlayerCell.swift
//  Sportify
//
//  Created by Ali_Kotb on 31/05/2025.
//

import UIKit

class PlayerCell: UITableViewCell {

    @IBOutlet weak var backCell: UIView!
    @IBOutlet weak var playerNum: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerImg: UIImageView!
    @IBOutlet weak var playerType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
//        backCell.layer.cornerRadius = 12
//        backCell.layer.borderWidth = 1
//        backCell.layer.borderColor = UIColor.red.cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 4, right: 16))
        applyGradientBackground(to: backCell, cornerRadius: 12, style: .defaultCell)
    }
    
    
}
