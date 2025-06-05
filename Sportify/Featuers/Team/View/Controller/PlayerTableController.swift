//
//  PlayerTableController.swift
//  Sportify
//
//  Created by Ali_Kotb on 31/05/2025.
//

import UIKit
import Kingfisher
protocol TeamProtocol{
    func renderToView(res : [Team])
}

class PlayerTableController: UIViewController ,UITableViewDelegate,UITableViewDataSource,TeamProtocol {

    @IBOutlet weak var myHeader: UIView!
    @IBOutlet weak var myTable: UITableView!
    var presenter : TeamPresenter!

    var headerView: TeamCell?
    override func viewDidLoad() {
       super.viewDidLoad()

       self.myTable.delegate = self
       self.myTable.dataSource = self
       

       let nibPlayer = UINib(nibName: "PlayerCell", bundle: nil)
       myTable.register(nibPlayer, forCellReuseIdentifier: "playercell")
       let screenHeight = UIScreen.main.bounds.height

       if let loadedHeaderView = Bundle.main.loadNibNamed("TeamCell", owner: self, options: nil)?.first as? TeamCell {
           headerView = loadedHeaderView
           myHeader.addSubview(headerView!)

           headerView!.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               headerView!.topAnchor.constraint(equalTo: myHeader.topAnchor),
               headerView!.leadingAnchor.constraint(equalTo: myHeader.leadingAnchor),
               headerView!.trailingAnchor.constraint(equalTo: myHeader.trailingAnchor),
               headerView!.bottomAnchor.constraint(equalTo: myHeader.bottomAnchor),
               myHeader.heightAnchor.constraint(equalToConstant: screenHeight / 3)

           ])
       }
       self.navigationItem.backButtonTitle = "Leagues details"
       self.navigationItem.title = presenter.teamName
       let attributes: [NSAttributedString.Key: Any] = [
           .font: UIFont.systemFont(ofSize: 24, weight: .bold),
           .foregroundColor: UIColor.red
       ]
       navigationController?.navigationBar.titleTextAttributes = attributes
           
        LoadingIndicatorUtil.shared.show(on: self.view)
        presenter.getDataFromModel()
   }

    func renderToView(res : [Team])
    {
        self.presenter.setLiset(teamList: res)
        DispatchQueue.main.async {
            if let logoURL = URL(string: self.presenter.getTeamLogo()) {
                        self.headerView?.clubImg.kf.setImage(with: logoURL)
                    }
            self.myTable.reloadData()
            LoadingIndicatorUtil.shared.hide()
        }
    }

     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getPlayerListCount() + presenter.getCoachListCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playercell", for: indexPath) as! PlayerCell
        
        let playerCount = presenter.getPlayerListCount()
        
        if indexPath.row < presenter.getCoachListCount() {
               let coach = presenter.getCoachObject(indexPath: indexPath.row)
               
               cell.playerNum.text = coach.coachAge
               cell.playerName.text = coach.coachName
               cell.playerType.text = "\(NSLocalizedString("coach", comment: "hamda"))"
            cell.playerImg.image = UIImage(named: "player")

           } else {
               let playerIndex = indexPath.row - presenter.getCoachListCount()
               let player = presenter.getPlayerObject(indexPath: playerIndex)
               
               if let urlString = player.playerImage, let url = URL(string: urlString) {
                   cell.playerImg.kf.setImage(with: url, placeholder: UIImage(named: "player"))
               }
               cell.playerNum.text = player.playerNumber
               cell.playerName.text = player.playerName
               cell.playerType.text = "\(getTeamMemberType(member:player.playerType)) "
           }

        return cell
    }


     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 156
    }

   

   
}
