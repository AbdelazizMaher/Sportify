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
    
    @IBOutlet weak var backCell: UIView!
    var deleteAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.red.cgColor
        favBtn.imageView?.contentMode = .scaleAspectFit
        favBtn.imageEdgeInsets = .zero
        favBtn.contentEdgeInsets = .zero
        favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        
        leagueImg.clipsToBounds = true
        leagueImg.contentMode = .scaleAspectFit
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leagueImg.layer.cornerRadius = leagueImg.frame.size.width / 1.88
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16))
        applyGradientBackground(to: backCell, cornerRadius: 12, style: .defaultCell)
    }
    
    @IBAction func deleteFromFav(_ sender: Any) {
        deleteAction?()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    


}





