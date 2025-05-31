//
//  Presenter.swift
//  Sportify
//
//  Created by Ali_Kotb on 30/05/2025.
//

import Foundation

class LeaguePresenter{
    let service = NetworkServiceCM()
    var vc : LeagueProtocol!
    var sport : String
    private var list : [League] = []
    
    init(sport: String, vc: LeagueProtocol!) {
        self.vc = vc
        self.sport = sport
    }
    
    func setLiset(list : [League]){
        self.list = list
        
    }
    
    func getDataFromModel(){
        service.fetchDataFromApi(sport:self.sport, met: "Leagues", handler: {
            res in
            DispatchQueue.main.async {
                self.vc.renderToView(res: res ?? [])
            }
            
        })
    }
    
    func getListCount() ->Int{
        list.count
    }
    
    func getLeagueObject (indexPath : Int) -> League{
        return list[indexPath]
    }
 
    
}
