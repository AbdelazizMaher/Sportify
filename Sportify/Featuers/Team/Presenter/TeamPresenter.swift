//
//  TeamPresenter.swift
//  Sportify
//
//  Created by Ali_Kotb on 31/05/2025.
//

import Foundation

class TeamPresenter{
    let service = NetworkServiceCM()
    var vc : TeamProtocol!

    private var teamList : [Team] = []

    private var playerList : [Player] = []
    
    private var coachList : [Coach] = []
    
    private var teamLogo : String = ""
    var teamID : String
    var teamName :String
    func getTeamLogo ()-> String{ return teamLogo}
    
    init(vc: TeamProtocol!, teamID: String, teamName: String) {
        self.vc = vc
        self.teamID = teamID
        self.teamName = teamName
    }
    
    func setLiset(teamList : [Team]){
        self.teamList = teamList
        
    }
    
    
    
    func getDataFromModel() {
        service.fetchDataFromApi(sport:"football", met: "Teams", teamId: self.teamID, handler: { [weak self] res in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.teamList = res ?? []
                if let firstTeam = self.teamList.first {
                    self.playerList = firstTeam.players
                    self.coachList = firstTeam.coaches
                    self.teamLogo = firstTeam.teamLogo ?? ""
                }
                self.vc.renderToView(res: self.teamList)

            }
        })
    }

    func getPlayerListCount() ->Int{
        playerList.count
    }
    
    func getPlayerObject (indexPath : Int) -> Player{
        return playerList[indexPath]
    }
    
    func getCoachListCount() ->Int{
        coachList.count
    }
    
    func getCoachObject (indexPath : Int) -> Coach{
        return coachList[indexPath]
    }
 
    
}
