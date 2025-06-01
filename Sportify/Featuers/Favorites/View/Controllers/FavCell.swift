//
//  FavCell.swift
//  Sportify
//
//  Created by Ali_Kotb on 01/06/2025.
//

import UIKit

class FavCell: UITableViewCell {

    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var leageuLabel: UILabel!
    @IBOutlet weak var leagueImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        favBtn.imageView?.contentMode = .scaleAspectFit
          favBtn.imageEdgeInsets = .zero
          favBtn.contentEdgeInsets = .zero

          if let image = UIImage(systemName: "heart.fill") {
              favBtn.setImage(image.withConfiguration(UIImage.SymbolConfiguration(pointSize: 24)), for: .normal)
          }
        leagueImg.clipsToBounds = true
        leagueImg.contentMode = .scaleAspectFill
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        leagueImg.layer.cornerRadius = leagueImg.frame.width / 2
    }

    @IBAction func deleteFromFav(_ sender: Any) {
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

