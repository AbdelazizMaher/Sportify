//
//  Colors.swift
//  Sportify
//
//  Created by Ali_Kotb on 04/06/2025.
//
import UIKit

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}

enum GradientStyle {
    case defaultCell
    case SeconderyCell
    
    var colors: [CGColor] {
        let isDark = UITraitCollection.current.userInterfaceStyle == .dark
        
        switch self {
        case .defaultCell:
            return isDark ?
                [UIColor(hex: "#2C3E50").cgColor, UIColor(hex: "#4CA1AF").cgColor] :
                [UIColor(hex: "#F5F7FA").cgColor, UIColor(hex: "#DADADA").cgColor]
            
        case .SeconderyCell:
            return isDark ?
                [UIColor(hex: "#232526").cgColor, UIColor(hex: "#414345").cgColor] :
                [UIColor(hex: "#EFFFE6").cgColor, UIColor(hex: "#FFECFF").cgColor]  
        }
    }
}

func applyGradientBackground(to view: UIView, cornerRadius: CGFloat = 12, style: GradientStyle) {
    view.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = view.bounds
    gradientLayer.cornerRadius = cornerRadius
    gradientLayer.colors = style.colors
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    
    view.layer.insertSublayer(gradientLayer, at: 0)
}



