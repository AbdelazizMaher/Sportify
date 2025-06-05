//
//  LeageuViewCell.swift
//  Sportify
//
//  Created by Ali_Kotb on 30/05/2025.
//

import UIKit

class LeagueViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.red.cgColor

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16))
        applyGradientBackground(to: contentView, cornerRadius: 12, style: .defaultCell)

    }
    
}
