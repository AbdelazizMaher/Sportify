//
//  ViewController.swift
//  Sportify
//
//  Created by Abdelaziz on 29/05/2025.
//

import UIKit
import Kingfisher
import Lottie

class ViewController: UIViewController {

    @IBOutlet weak var animation: LottieAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let isFirst = getIsFirstTime()
       
        animation.animationSpeed = 0.5
        animation.play()
        if !isFirst {
              DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                  let onboardingVC = OnBoardingViewController()
                  self.navigationController?.setViewControllers([onboardingVC], animated: true)

              }
          } else {
              DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                  self.navigateToHome()
              }
          }
    }
    
    private func navigateToHome() {
        let homeStoryboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let tabBarController = homeStoryboard.instantiateViewController(withIdentifier: "mainTabBar") as! CustomTabBarController
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = tabBarController
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }


}

