//
//  OnBoardingViewController.swift
//  Sportify
//
//  Created by Abdelaziz on 29/05/2025.
//

import UIKit

class OnBoardingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides : [OnBoardingSlides] = []
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                navBtn.setTitle("Get Started", for: .normal)
            } else {
                navBtn.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "OnBoardingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "onBoarding")

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        slides = [
            OnBoardingSlides(title: "slide 1", description: "description1", image: UIImage(named: "man")!),
            OnBoardingSlides(title: "slide 2", description: "description2", image: UIImage(named: "man")!),
            OnBoardingSlides(title: "slide 3", description: "description3", image: UIImage(named: "man")!)
        ]
        
        pageControl.numberOfPages = slides.count
        collectionView.reloadData()
    }
    
    @IBAction func navToNext(_ sender: Any) {
        if currentPage == slides.count - 1 {
            setIsFirstTime(isFirst: true)
           // let homeVC = storyboard?.instantiateViewController(identifier: "HomeVC") as! HomeViewController
           // navigationController?.setViewControllers([homeVC], animated: true)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onBoarding", for: indexPath) as! OnBoardingCollectionViewCell
        
        cell.setCurrentSlide(slide: slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
