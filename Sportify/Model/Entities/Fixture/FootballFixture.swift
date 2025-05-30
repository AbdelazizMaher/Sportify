//
//  Fixture.swift
//  Sportify
//
//  Created by Abdelaziz on 30/05/2025.
//

import Foundation


struct FootballFixture: Decodable {
    let eventKey: Int
    let eventDate: String?
    let eventTime: String?
    let eventHomeTeam: String?
    let homeTeamKey: Int
    let eventAwayTeam: String?
    let awayTeamKey: Int
    let eventFinalResult : String?
    let eventStatus: String?
    let homeTeamLogo, awayTeamLogo: String?

    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventHomeTeam = "event_home_team"
        case homeTeamKey = "home_team_key"
        case eventAwayTeam = "event_away_team"
        case awayTeamKey = "away_team_key"
        case eventFinalResult = "event_final_result"
        case eventStatus = "event_status"
        case homeTeamLogo = "home_team_logo"
        case awayTeamLogo = "away_team_logo"
    }
}

