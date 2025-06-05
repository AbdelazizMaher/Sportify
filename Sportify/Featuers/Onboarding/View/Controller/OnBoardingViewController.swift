//
//  OnboardinggggViewController.swift
//  Sportify
//
//  Created by Abdelaziz on 04/06/2025.
//

import UIKit

class OnBoardingViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    private var pageVC: UIPageViewController!
    private var pages = [OnBoardingSlidesViewController]()
    private let pageControl = UIPageControl()
    private let skipButton = UIButton()
        
    private var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setIsFirstTime(isFirst: true)
        setupPages()
        setupPageViewController()
        setupControls()
    }
    
    private func setupPages() {
        pages = [
            OnBoardingSlidesViewController(
                imageName: "footSlide",
                labelText: NSLocalizedString("slide1_txt", comment: "First slide text"),
                labelPosition: .bottom
            ),
            OnBoardingSlidesViewController(
                imageName: "basketSlide2",
                labelText: NSLocalizedString("slide2_txt", comment: "Second slide text"),
                labelPosition: .top
            ),
            OnBoardingSlidesViewController(
                imageName: "cricketSlide",
                labelText: NSLocalizedString("slide3_txt", comment: "Third slide text"),
                labelPosition: .bottom
            ),
            OnBoardingSlidesViewController(
                imageName: "stadiumSlide",
                labelText: NSLocalizedString("slide4_txt", comment: "Fourth slide text"),
                labelPosition: .bottom
            )
        ]
    }
    
    private func setupPageViewController() {
        pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageVC.dataSource = self
        pageVC.delegate = self
        pageVC.setViewControllers([pages[0]], direction: .forward, animated: true)
        addChild(pageVC)
        view.addSubview(pageVC.view)
        pageVC.didMove(toParent: self)
    }
    
    private func setupControls() {
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)
        
        skipButton.setTitle(NSLocalizedString("Skip", comment: "Skip button title"), for: .normal)
        skipButton.setTitleColor(.white, for: .normal)
        skipButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(skipButton)
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func skipTapped() {
        navigateToHome()
    }
    
    private func navigateToHome() {
        let homeStoryboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let tabBarController = homeStoryboard.instantiateViewController(withIdentifier: "mainTabBar") as! CustomTabBarController
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = tabBarController
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }
        
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! OnBoardingSlidesViewController), index > 0 else { return nil }
        return pages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! OnBoardingSlidesViewController), index < pages.count - 1 else { return nil }
        return pages[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if completed, let visibleVC = pageViewController.viewControllers?.first as? OnBoardingSlidesViewController,
           let index = pages.firstIndex(of: visibleVC) {
            currentIndex = index
            pageControl.currentPage = currentIndex
            
            skipButton.setTitle(currentIndex == pages.count - 1 ? NSLocalizedString("Done", comment: "Done button title") : NSLocalizedString("Skip", comment: "Skip button title"), for: .normal)
        }
    }

}
