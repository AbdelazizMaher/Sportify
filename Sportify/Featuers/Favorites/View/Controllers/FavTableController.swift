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
          headerLabel.text = "Favorites"
          headerLabel.font = UIFont.boldSystemFont(ofSize: 28)
          headerLabel.textColor = .label
          headerLabel.textAlignment = .center
          headerLabel.backgroundColor = .systemBackground
          headerLabel.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60)
          tableView.tableHeaderView = headerLabel
        let nibPlayer = UINib(nibName: "FavCell", bundle: nil)
        tableView.register(nibPlayer, forCellReuseIdentifier: "favcell")
        presenter.vc = self
        presenter.getAllFav()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
            cell.leagueImg.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        }else{
            cell.leagueImg.image = UIImage(systemName: "photo")
        }
        cell.deleteAction = {
            self.presenter.deleteFromCore(objc: obj)
            self.presenter.getAllFav()
            self.tableView.reloadData()
        }
        
        let heartImage = presenter.checkFav(id: obj.leagueKey) ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        cell.favBtn.setImage(heartImage, for: .normal)

        return cell
    }

   
 
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
