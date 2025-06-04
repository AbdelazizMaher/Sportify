//
//  HomePresenter.swift
//  Sportify
//
//  Created by Abdelaziz on 31/05/2025.
//

import Foundation

protocol HomePresenterProtocol {
    var sports: [SportItem] { get }
    func numberOfItems() -> Int
    func item(index: Int) -> SportItem
}


class HomePresenter : HomePresenterProtocol {
    private(set) var sports: [SportItem] = [
        SportItem(name: NSLocalizedString("football_home", comment: "hamda"), imageName: "foot1", type: SportsType.football),
        SportItem(name: NSLocalizedString("basket_home", comment: "hamda"), imageName: "basket1", type: SportsType.basketball),
        SportItem(name: NSLocalizedString("tennis_home", comment: "hamda"), imageName: "tennis1", type: SportsType.tennis),
        SportItem(name: NSLocalizedString("cricket_home", comment: "hamda"), imageName: "cricket2", type: SportsType.cricket)
    ]
    
    func numberOfItems() -> Int {
        return sports.count
    }
    
    func item(index: Int) -> SportItem {
        return sports[index]
    }
}
