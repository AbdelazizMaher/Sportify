//
//  FavTableController.swift
//  Sportify
//
//  Created by Ali_Kotb on 01/06/2025.
//

import UIKit
import Kingfisher

protocol FavProtocol{
    func renderToView(res : [LeagueLocal])
}

class FavTableController: UITableViewController, FavProtocol {
    let presenter = FavPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let headerLabel = UILabel()
          headerLabel.text = NSLocalizedString("fav_title", comment: "hamda")
          headerLabel.font = UIFont.boldSystemFont(ofSize: 28)
          headerLabel.textColor = .red
          headerLabel.textAlignment = .center
          headerLabel.backgroundColor = .systemBackground
          headerLabel.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60)
          tableView.tableHeaderView = headerLabel
        let nibPlayer = UINib(nibName: "FavCell", bundle: nil)
        tableView.register(nibPlayer, forCellReuseIdentifier: "favcell")
        presenter.vc = self
        presenter.getAllFav()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let customTabBar = self.tabBarController as? CustomTabBarController {
            customTabBar.setTabBarHidden(false)
        }
        presenter.getAllFav()
    }


    func renderToView(res: [LeagueLocal]) {
        presenter.setList(list: res)
          tableView.reloadData()
      }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return presenter.getFavCount()
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favcell", for: indexPath) as! FavCell

        let obj = presenter.getFavByIndexPath(indexPath: indexPath.row)

        cell.leageuLabel.text = obj.leagueName
        if let url = URL(string: obj.leagueLogo) {
            cell.leagueImg.kf.setImage(with: url, placeholder: UIImage(named: "trophy"))
        }else{
            cell.leagueImg.image = UIImage(named: "trophy")
        }
        cell.deleteAction = {
            self.showAlert(title: DELETE_ALERT_TITLE, message:  DELETE_ALERT_MSG ,cancelTitle: DELETE_ALERT_CANCEL,deleteTitle: DELETE_ALERT_OK,onDelete: {
                
                self.presenter.deleteFromCore(objc: obj)
                self.presenter.getAllFav()
                self.tableView.reloadData()
            })
           
        }
        
        let heartImage = presenter.checkFav(id: obj.leagueKey) ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        cell.favBtn.setImage(heartImage, for: .normal)

        return cell
    }

   
 
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell selected!")

        if NetworkManager.isInternetAvailable() {
            let storyboard = UIStoryboard(name: "LeagueDetailsScreen", bundle: nil)
            let detailsVC = storyboard.instantiateViewController(withIdentifier: "details") as! DetailsCollectionViewController

            let league = self.presenter.getFavByIndexPath(indexPath: indexPath.row)

            let leagueKey = league.leagueKey
            let leagueName = league.leagueName
            let leagueLogo = league.leagueLogo

            detailsVC.presenter = LeagueDetailsPresenter(
                view: detailsVC,
                sportType: league.sport,
                leagueId: Int(leagueKey),
                leagueName: leagueName,
                leagueLogo: leagueLogo
            )

            navigationController?.pushViewController(detailsVC, animated: true)
        } else {
            showAlert(title: "No Internet Connection", message: "Please check your connection and try again.", okTitle: "Ok")
        }
        
    }




}
