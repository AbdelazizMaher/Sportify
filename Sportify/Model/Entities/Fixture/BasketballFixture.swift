//
//  BasketballFixture.swift
//  Sportify
//
//  Created by Abdelaziz on 30/05/2025.
//

import Foundation

struct BasketballFixture: Codable {
    let eventKey: Int
    let eventDate, eventTime, eventHomeTeam: String?
    let homeTeamKey: Int
    let eventAwayTeam: String?
    let awayTeamKey: Int
    let eventFinalResult: String?
    let eventStatus: String?
    let eventHomeTeamLogo, eventAwayTeamLogo: String?

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
        case eventHomeTeamLogo = "event_home_team_logo"
        case eventAwayTeamLogo = "event_away_team_logo"
    }
}
