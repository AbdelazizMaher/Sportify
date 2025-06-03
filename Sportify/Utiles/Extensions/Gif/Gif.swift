//
//  Gif.swift
//  Sportify
//
//  Created by Ali_Kotb on 03/06/2025.
//

import UIKit
import ImageIO

extension UIImageView {
    func loadGif(named name: String) {
        DispatchQueue.global().async {
            guard let path = Bundle.main.path(forResource: name, ofType: "gif"),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
                  let source = CGImageSourceCreateWithData(data as CFData, nil) else { return }

            var images = [UIImage]()
            let count = CGImageSourceGetCount(source)

            for i in 0..<count {
                if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                    images.append(UIImage(cgImage: cgImage))
                }
            }

            DispatchQueue.main.async {
                self.animationImages = images
                self.animationDuration = 5.0
                self.startAnimating()
            }
        }
    }
}
