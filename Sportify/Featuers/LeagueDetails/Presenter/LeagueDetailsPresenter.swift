//
//  LeagueDetailsPresenter.swift
//  Sportify
//
//  Created by Abdelaziz on 31/05/2025.
//

import Foundation

protocol LeagueDetailsPresenterProtocol {
    var upcomingMatches: [Any] { get }
    var latestMatches: [Any] { get }
    var teams: [Team] { get }
}

class LeagueDetailsPresenter {
    let service = NetworkServiceCM()
    var view : LeagueDetailsProtocol!
    
    private let sportType: String
    private let leagueId: Int
    
    private(set) var upcomingMatches: [Any] = []
    private(set) var latestMatches: [Any] = []
    private(set) var teams: [Team] = []
    
    init(view: LeagueDetailsProtocol!, sportType: String, leagueId: Int) {
        self.view = view
        self.sportType = sportType
        self.leagueId = leagueId
    }
    
    func getUpcomingEvents() {
        let dateRange = DateUtility.shared.getDateRange(for: sportType, isUpcoming: true)
        fetchFixtures(from: dateRange.from, to: dateRange.to, isUpcoming: true)
    }
    
    func getLatestEvents() {
        let dateRange = DateUtility.shared.getDateRange(for: sportType, isUpcoming: false)
        fetchFixtures(from: dateRange.from, to: dateRange.to, isUpcoming: false)
    }
    
    func getAllTeams() {
        service.fetchDataFromApi(sport: sportType, met: APIMethods.teams.rawValue, leagueId: String(leagueId), handler: {[weak self] (matches: [Team]?) in
            if let matches = matches {
                DispatchQueue.main.async {
                    self?.teams = matches
                    self?.view?.reloadTeamsSection()
                }
            }
        })
    }
    
    
    private func fetchFixtures(from: String, to: String, isUpcoming: Bool) {
        service.fetchDataFromApi(sport: sportType, met: APIMethods.fixtures.rawValue, from: from, to: to, leagueId: String(leagueId), handler: { [weak self] (matches: [Fixture]?) in
            if let matches = matches {
                DispatchQueue.main.async {
                    if isUpcoming {
                        self?.upcomingMatches = matches
                        self?.view?.reloadUpcomingSection()
                    }else {
                        self?.latestMatches = matches
                        self?.view?.reloadLatestSection()
                    }
                }
            }
        })
    }
    
    func updateFavoriteButton(isFavorite: Bool) {
        
    }
}
