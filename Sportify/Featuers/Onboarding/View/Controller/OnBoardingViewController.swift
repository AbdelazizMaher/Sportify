//
//  OnBoardingViewController.swift
//  Sportify
//
//  Created by Abdelaziz on 29/05/2025.
//

import UIKit

class OnBoardingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
        
    private var slides: [OnBoardingSlides] = []
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            updateNavButtonTitle()
            collectionView.reloadData()
        }
    }
    private var isLastPage: Bool {
        return currentPage == slides.count - 1
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setupSlides()
        pageControl.numberOfPages = slides.count
    }
        
    @IBAction func navToNext(_ sender: Any) {
        if isLastPage {
            setIsFirstTime(isFirst: true)
            navigateToHome()
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
        
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        
        collectionView.register(
            UINib(nibName: "OnBoardingCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "onBoarding"
        )
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        
    }
    
    private func setupSlides() {
        slides = [
            OnBoardingSlides(
                title: "Welcome to Sportify!",
                description: "Track your favorite leagues, teams, and players — all in one place. Stay in the game, anytime, anywhere.",
                image: UIImage(named: "slide1")!
            ),
            OnBoardingSlides(
                title: "Stay Ahead of the Action",
                description: "Get real-time match updates, player stats, and league standings delivered straight to your screen.",
                image: UIImage(named: "slide1")!
            ),
            OnBoardingSlides(
                title: "Build Your Dream Lineup",
                description: "Discover upcoming matches, follow your star players, and never miss a moment of the action.",
                image: UIImage(named: "slide1")!
            )
        ]
    }
    
    private func updateNavButtonTitle() {
        navBtn.setTitle(isLastPage ? "Get Started" : "Next", for: .normal)
    }
    
    private func navigateToHome() {
        let homeStoryboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let tabBarController = homeStoryboard.instantiateViewController(withIdentifier: "mainTabBar") as! CustomTabBarController
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = tabBarController
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onBoarding", for: indexPath) as! OnBoardingCollectionViewCell
        
        cell.setCurrentSlide(slide: slides[indexPath.item])
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        let height = collectionView.frame.size.height
        print("Cell width: \(width)")
        print("Cell height: \(height)")
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
    }
}
