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
    
    let sportType: String
    let leagueId: Int
    let leagueName : String
    let leagueLogo : String?
    
    private(set) var upcomingMatches: [Any] = []
    private(set) var latestMatches: [Any] = []
    private(set) var teams: [Team] = []
    

    init(view: LeagueDetailsProtocol!, sportType: String, leagueId: Int, leagueName: String, leagueLogo: String) {
        self.view = view
        self.sportType = sportType
        self.leagueId = leagueId
        self.leagueName = leagueName
        self.leagueLogo = leagueLogo
        
    }
    
    func getUpcomingEvents() {
        let dateRange = DateUtility.shared.getDateRange(for: sportType, isUpcoming: true)
        fetchFixtures(from: dateRange.from, to: dateRange.to, isUpcoming: true)
    }
    
    func getLatestEvents() {
        let dateRange = DateUtility.shared.getDateRange(for: sportType, isUpcoming: false)
        fetchFixtures(from: dateRange.from, to: dateRange.to, isUpcoming: false)
    }
    
//    func getAllTeams() {
//        service.fetchDataFromApi(sport: sportType, met: APIMethods.teams.rawValue, leagueId: String(leagueId), handler: {[weak self] (matches: [Team]?) in
//            if let matches = matches {
//                DispatchQueue.main.async {
//                    self?.teams = matches
//                    self?.view?.reloadTeamsSection()
//                }
//            }
//        })
//    }
    
    func getAllTeams() {
        if sportType.lowercased() == "tennis" {
            extractPlayersFromFixtures()
        } else {
            fetchRegularTeams()
        }
    }

    private func fetchRegularTeams() {
        service.fetchDataFromApi(sport: sportType,met: APIMethods.teams.rawValue,leagueId: String(leagueId),handler: { [weak self] (teams: [Team]?) in
                DispatchQueue.main.async {
                    self?.teams = teams ?? []
                    self?.view?.reloadTeamsSection()
                }
            }
        )
    }

    private func extractPlayersFromFixtures() {
        let dateRange = DateUtility.shared.getDateRange(for: SportsType.tennis.rawValue, isUpcoming: false)
        service.fetchDataFromApi(sport: sportType, met: APIMethods.fixtures.rawValue, from: dateRange.from, to: dateRange.to, leagueId: String(leagueId), handler: { [weak self] (matches: [Fixture]?) in
            if let matches = matches {
                var players = [Team]()
                
                for fixture in matches {
                    if let tennisFixture = fixture as? Fixture {
                        if let player1 = tennisFixture.homeParticipant,
                           let playerKey = tennisFixture.homeParticipantKey {
                            players.append(Team(
                                teamKey: playerKey,
                                teamName: player1,
                                teamLogo: tennisFixture.homeParticipantLogo,
                                players: [],
                                coaches: []
                            ))
                        }
                        
                        if let player2 = tennisFixture.awayParticipant,
                           let playerKey = tennisFixture.awayParticipantKey {
                            players.append(Team(
                                teamKey: playerKey,
                                teamName: player2,
                                teamLogo: tennisFixture.awayParticipantLogo,
                                players: [],
                                coaches: []
                            ))
                        }
                    }
                }
                
                var uniquePlayers = [Team]()
                var seenKeys = Set<Int>()
                
                for player in players {
                    if !seenKeys.contains(player.teamKey) {
                        uniquePlayers.append(player)
                        seenKeys.insert(player.teamKey)
                    }
                }
                DispatchQueue.main.async {
                    self?.teams = uniquePlayers
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
