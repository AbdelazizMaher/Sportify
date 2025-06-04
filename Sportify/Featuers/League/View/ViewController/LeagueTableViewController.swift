//
//  LeageuTableViewController.swift
//  Sportify
//
//  Created by Ali_Kotb on 30/05/2025.
//

import UIKit
import Kingfisher

protocol LeagueProtocol{
    func renderToView(res : [League])
}

class LeagueTableViewController: UITableViewController, LeagueProtocol {
    var sport : String = "football"
    var presenter : LeaguePresenter!
    
    private var bannerView: UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Leagues"
        let attributes: [NSAttributedString.Key: Any] = [
             .font: UIFont.systemFont(ofSize: 24, weight: .bold),
             .foregroundColor: UIColor.red
         ]
        navigationController?.navigationBar.titleTextAttributes = attributes
        let nib = UINib(nibName: "LeagueViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        presenter = LeaguePresenter(sport:sport,vc : self)
        presenter.getDataFromModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let customTabBar = self.tabBarController as? CustomTabBarController {
            customTabBar.setTabBarHidden(true)
        }
    }



    func renderToView(res : [League]){
        self.presenter.setLiset(list: res)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return presenter.getListCount()
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeagueViewCell

        cell.contentView.layer.borderWidth = 0.5
        cell.contentView.layer.borderColor = UIColor.gray.cgColor
        let obj = presenter.getLeagueObject(indexPath: indexPath.row)

        let bigImg = obj.leagueLogo ?? ""
        let smallImg = obj.countryLogo ?? ""

        var title : String = ""
        var subTitle : String = ""
        if sport == "cricket"{
            title  = obj.leagueName!
             subTitle  = obj.leagueYear!
        }else{
            title  = obj.leagueName!
             subTitle  = obj.countryName!
            
        }
        if let imageView2 = cell.contentView.viewWithTag(2) as? UIImageView {
            if sport != "football" {
                imageView2.isHidden = true
            } else {
                imageView2.isHidden = false
                if let url = URL(string: smallImg) {
                    imageView2.kf.setImage(with: url)
                }
            }
        }

        
        if let imageView = cell.contentView.viewWithTag(1) as? UIImageView {
            if let url = URL(string: bigImg) {
                 imageView.kf.setImage(with: url,placeholder: UIImage(named: "trophy"))
             }
            imageView.layer.cornerRadius = imageView.frame.size.width / 2
              imageView.clipsToBounds = true
        }
       
        
     

        if let cellTitle = cell.contentView.viewWithTag(3) as? UILabel {
            cellTitle.text = title
        }
        
        if let cellSubTitle = cell.contentView.viewWithTag(4) as? UILabel {
            cellSubTitle.text = subTitle
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if NetworkManager.isInternetAvailable() {
            let storyboard = UIStoryboard(name: "LeagueDetailsScreen", bundle: nil)
            let detailsVC = storyboard.instantiateViewController(withIdentifier: "details") as! DetailsCollectionViewController

            let league = self.presenter.getLeagueObject(indexPath: indexPath.row)

            let leagueKey = league.leagueKey
            let leagueName = league.leagueName ?? "Unknown League"
            let leagueLogo = league.leagueLogo ?? ""

            detailsVC.presenter = LeagueDetailsPresenter(
                view: detailsVC,
                sportType: self.sport,
                leagueId: leagueKey ?? 0 ,
                leagueName: leagueName,
                leagueLogo: leagueLogo
            )
            
            navigationController?.pushViewController(detailsVC, animated: true)
        } else {
            showAlert(title: "No Internet Connection", message: "Please check your connection and try again.", okTitle: "Ok")
        }
        
    }
}
