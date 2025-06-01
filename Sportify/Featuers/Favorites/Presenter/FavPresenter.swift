//
//  FavPresenter.swift
//  Sportify
//
//  Created by Ali_Kotb on 01/06/2025.
//

import Foundation


class FavPresenter {
    private(set) var list: [LeagueLocal]?
    var vc: FavProtocol!

    private let localDataSource = LocalDataSource.shared

    func getFavCount() -> Int {
        return list?.count ?? 0
    }
    
    func setList(list: [LeagueLocal]){
        self.list = list
    }

    func getAllFav() {
        list = localDataSource.getAllLeague()
        vc.renderToView(res: list ?? [])
    }
    
    func getFavByIndexPath(indexPath: Int)->LeagueLocal{
        return (self.list?[indexPath])!
    }
    
    func addToCore(objc: LeagueLocal){
        localDataSource.saveLeague(obj: objc)
    }
    func deleteFromCore(objc: LeagueLocal){
        localDataSource.deleteLeague(obj: objc)
    }
    func checkFav(id: Int16)->Bool{
        return localDataSource.checkIsFavorite(leagueKey: id)
    }
}

