//
//  PlayerCell.swift
//  Sportify
//
//  Created by Ali_Kotb on 31/05/2025.
//

import UIKit

class PlayerCell: UITableViewCell {

    @IBOutlet weak var playerNum: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerImg: UIImageView!
    @IBOutlet weak var playerType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
