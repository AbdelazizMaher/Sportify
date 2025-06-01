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
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let fromDate = dateFormatter.string(from: currentDate)
        
        guard let futureDate = Calendar.current.date(byAdding: .day, value: 15, to: currentDate) else { return }
        let toDate = dateFormatter.string(from: futureDate)
        
        
       fetchFixtures(from: fromDate, to: toDate, isUpcoming: true)
        
    }
    
    func getLatestEvents() {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let toDate = dateFormatter.string(from: currentDate)
        
        guard let pastDate = Calendar.current.date(byAdding: .day, value: -8, to: currentDate) else { return }
        let fromDate = dateFormatter.string(from: pastDate)
        
        fetchFixtures(from: fromDate, to: toDate, isUpcoming: false)
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
}
