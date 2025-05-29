//
//  OnBoardingCollectionViewCell.swift
//  Sportify
//
//  Created by Abdelaziz on 29/05/2025.
//

import UIKit

class OnBoardingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTxt: UILabel!
    @IBOutlet weak var descriptionTxt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCurrentSlide(slide: OnBoardingSlides) {
        imageView.image = slide.image
        titleTxt.text = slide.title
        descriptionTxt.text = slide.description
    }

}
