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
        var isFirst = getIsFirstTime()
        
//        setIsFirstTime(isFirst: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
       
        animation.animationSpeed = 0.5
        animation.play()
        if isFirst {
              DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                  let vc = storyboard.instantiateViewController(withIdentifier: "onboard")
                  self.navigationController?.pushViewController(vc, animated: true)
              }
          } else {
              DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                  let vc = storyboard.instantiateViewController(withIdentifier: "home")
                  self.navigationController?.pushViewController(vc, animated: true)
              }
          }
        
        // Do any additional setup after loading the view.
    }


}

