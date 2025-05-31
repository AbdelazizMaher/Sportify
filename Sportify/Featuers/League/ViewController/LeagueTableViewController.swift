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
    
        override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Leagues"
            let attributes: [NSAttributedString.Key: Any] = [
                 .font: UIFont.systemFont(ofSize: 24, weight: .bold),
                 .foregroundColor: UIColor.brown
             ]
             navigationController?.navigationBar.titleTextAttributes = attributes
        let nib = UINib(nibName: "LeagueViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        presenter = LeaguePresenter(sport:sport,vc : self)
        presenter.getDataFromModel()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
