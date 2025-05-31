//
//  CustomTabBarController.swift
//  Sportify
//
//  Created by Abdelaziz on 31/05/2025.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    private let floatingTabBarView = UIView()
    private let tabBarHeight: CGFloat = 60
    private let bottomPadding: CGFloat = 20
    private let sidePadding: CGFloat = 20
    private let cornerRadius: CGFloat = 24   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFloatingTabBar()
    }
    
    private func setupFloatingTabBar() {
        // 1. Configure default tab bar
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.isTranslucent = true
        tabBar.layer.masksToBounds = true
        
        // 2. Create custom floating background
        floatingTabBarView.backgroundColor = .clear
        floatingTabBarView.layer.shadowColor = UIColor.black.cgColor
        floatingTabBarView.layer.shadowOffset = CGSize(width: 0, height: 2)
        floatingTabBarView.layer.shadowOpacity = 0.1
        floatingTabBarView.layer.shadowRadius = 10
        
        // 3. Add blur effect
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        blurView.layer.cornerRadius = cornerRadius
        blurView.layer.masksToBounds = true
        floatingTabBarView.addSubview(blurView)
        
        // 4. Add to view hierarchy
        view.addSubview(floatingTabBarView)
        view.bringSubviewToFront(tabBar)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let safeAreaBottom = view.safeAreaInsets.bottom
        let totalHeight = tabBarHeight + bottomPadding + safeAreaBottom
        
        // 1. Position floating background
        floatingTabBarView.frame = CGRect(
            x: sidePadding,
            y: view.bounds.height - totalHeight,
            width: view.bounds.width - (sidePadding * 2),
            height: tabBarHeight + bottomPadding
        )
        
        // 2. Position actual tab bar (slightly above background bottom)
        tabBar.frame = CGRect(
            x: sidePadding,
            y: view.bounds.height - totalHeight,
            width: view.bounds.width - (sidePadding * 2),
            height: tabBarHeight
        )
        
        // 3. Update blur view to match rounded corners
        if let blurView = floatingTabBarView.subviews.first {
            blurView.frame = floatingTabBarView.bounds
            blurView.layer.cornerRadius = cornerRadius
        }
        
        // 4. Apply corner radius to tab bar
        tabBar.layer.cornerRadius = cornerRadius
        
        // 5. Adjust tab bar item positions if needed
        tabBar.items?.forEach {
            $0.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            $0.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 4)
        }
    }
}
