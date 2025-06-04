//
//  HomeCollectionViewController.swift
//  Sportify
//
//  Created by Abdelaziz on 31/05/2025.
//

import UIKit
import Reachability
private let reuseIdentifier = "Cell"

class HomeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private var presenter: HomePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

  
    
        presenter = HomePresenter()
            
            navigationItem.title = NSLocalizedString("home_title", comment: "hamda")
            navigationController?.navigationBar.titleTextAttributes = [
                .font: UIFont.boldSystemFont(ofSize: 28),
                .foregroundColor: UIColor.red
            ]
            
            collectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "homeCell")
            
            let storyboardB = UIStoryboard(name: "Favorite", bundle: nil)
            let favPage = storyboardB.instantiateViewController(withIdentifier: "fav")
            favPage.tabBarItem = UITabBarItem(title: NSLocalizedString("fav_title", comment: "hamda"), image: UIImage(systemName: "heart"), tag: 2)
            addFavoriteTab(favPage)
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let customTabBar = self.tabBarController as? CustomTabBarController {
            customTabBar.setTabBarHidden(false)
        }
    }

    
    private func addFavoriteTab(_ favPage: UIViewController) {
        if let tabBarController = self.tabBarController {
            var currentVCs = tabBarController.viewControllers ?? []
            
            let navController = UINavigationController(rootViewController: favPage)
            navController.tabBarItem = UITabBarItem(title: NSLocalizedString("fav_title", comment: "hamda"), image: UIImage(systemName: "heart"), tag: 2)
            
            if !currentVCs.contains(where: { $0.tabBarItem.tag == 2 }) {
                currentVCs.append(navController)
                tabBarController.viewControllers = currentVCs
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return presenter.numberOfItems()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCollectionViewCell
        
        let sportItem = presenter.item(index: indexPath.item)
        cell.sportTypeTxt.text = sportItem.name
        cell.imageView.image = UIImage(named: sportItem.imageName)
        
        cell.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if NetworkManager.isInternetAvailable() {
            let storyboard = UIStoryboard(name: "League", bundle:nil)
            let leaguesVC = storyboard.instantiateViewController(withIdentifier: "league") as! LeagueTableViewController
            leaguesVC.sport = presenter.item(index: indexPath.item).type.rawValue
            navigationController?.pushViewController(leaguesVC, animated: true)
        }else {
            showAlert(title: "No Internet Connection", message: "Please check your connection and try again.", okTitle: "Ok")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width * 0.45
        return CGSize(width: width, height: width * 1.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 60, left: 8, bottom: 40, right: 8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    
    
}
