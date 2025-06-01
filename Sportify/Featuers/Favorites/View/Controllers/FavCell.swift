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
    
    var deleteAction: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        favBtn.imageView?.contentMode = .scaleAspectFit
        favBtn.imageEdgeInsets = .zero
        favBtn.contentEdgeInsets = .zero

        // Set initial heart icon style
        favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)

        leagueImg.clipsToBounds = true
        leagueImg.contentMode = .scaleAspectFill
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        leagueImg.layer.cornerRadius = leagueImg.frame.width / 2
    }

    // This method is called when the delete button is tapped
    @IBAction func deleteFromFav(_ sender: Any) {
        deleteAction?()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}




