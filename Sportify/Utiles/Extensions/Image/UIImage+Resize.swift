//
//  UIImage+Resize.swift
//  Sportify
//
//  Created by Abdelaziz on 05/06/2025.
//

import Foundation
import UIKit

extension UIImage {
    func resized(to targetSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }.withRenderingMode(.alwaysOriginal)
    }
}
