//
//  CricketFixture.swift
//  Sportify
//
//  Created by Abdelaziz on 30/05/2025.
//

import Foundation

struct CricketFixture: Decodable {
    let eventKey: Int
    let eventDateStart, eventDateStop, eventTime, eventHomeTeam: String
    let homeTeamKey: Int
    let eventAwayTeam: String
    let awayTeamKey: Int
    let eventHomeFinalResult, eventAwayFinalResult: String
    let eventStatus: String
    let eventStadium: String
    let eventHomeTeamLogo, eventAwayTeamLogo: String?


    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDateStart = "event_date_start"
        case eventDateStop = "event_date_stop"
        case eventTime = "event_time"
        case eventHomeTeam = "event_home_team"
        case homeTeamKey = "home_team_key"
        case eventAwayTeam = "event_away_team"
        case awayTeamKey = "away_team_key"
        case eventHomeFinalResult = "event_home_final_result"
        case eventAwayFinalResult = "event_away_final_result"
        case eventStatus = "event_status"
        case eventStadium = "event_stadium"
        case eventHomeTeamLogo = "event_home_team_logo"
        case eventAwayTeamLogo = "event_away_team_logo"
    }
}
