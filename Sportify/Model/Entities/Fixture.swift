//
//  Fixture.swift
//  Sportify
//
//  Created by Abdelaziz on 31/05/2025.
//

import Foundation

struct Fixture: Decodable {
    let eventKey: Int
    let eventDate: String?
    let eventTime: String?
    let finalResult: String?
    
    let homeParticipant: String?
    let homeParticipantKey: Int?
    let awayParticipant: String?
    let awayParticipantKey: Int?
    let homeParticipantLogo: String?
    let awayParticipantLogo: String?
    
    let eventDateStart: String?
    let eventStatusInfo: String?
    let homeFinalResult: String?
    let awayFinalResult: String?
    
    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventDateStart = "event_date_start"
        case eventTime = "event_time"
        case finalResult = "event_final_result"
        case eventStatusInfo = "event_status_info"
        case homeFinalResult = "event_home_final_result"
        case awayFinalResult = "event_away_final_result"
        
        case eventHomeTeam = "event_home_team"
        case homeTeamKey = "home_team_key"
        case eventAwayTeam = "event_away_team"
        case awayTeamKey = "away_team_key"
        case eventFirstPlayer = "event_first_player"
        case firstPlayerKey = "first_player_key"
        case eventSecondPlayer = "event_second_player"
        case secondPlayerKey = "second_player_key"
        case eventHomeTeamLogo = "event_home_team_logo"
        case eventAwayTeamLogo = "event_away_team_logo"
        case eventFirstPlayerLogo = "event_first_player_logo"
        case eventSecondPlayerLogo = "event_second_player_logo"
        case homeTeamLogo = "home_team_logo"
        case awayTeamLogo = "away_team_logo"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        eventKey = try container.decode(Int.self, forKey: .eventKey)
        eventDate = try container.decodeIfPresent(String.self, forKey: .eventDate)
        eventTime = try container.decodeIfPresent(String.self, forKey: .eventTime)
        finalResult = try container.decodeIfPresent(String.self, forKey: .finalResult)
        eventStatusInfo = try container.decodeIfPresent(String.self, forKey: .eventStatusInfo)
        eventDateStart = try container.decodeIfPresent(String.self, forKey: .eventDateStart)
        homeFinalResult = try container.decodeIfPresent(String.self, forKey: .homeFinalResult)
        awayFinalResult = try container.decodeIfPresent(String.self, forKey: .awayFinalResult)
        
        if let firstPlayer = try container.decodeIfPresent(String.self, forKey: .eventFirstPlayer) {
            homeParticipant = firstPlayer
            awayParticipant = try container.decodeIfPresent(String.self, forKey: .eventSecondPlayer)
            homeParticipantKey = try container.decodeIfPresent(Int.self, forKey: .firstPlayerKey)
            awayParticipantKey = try container.decodeIfPresent(Int.self, forKey: .secondPlayerKey)
            
            homeParticipantLogo = (try? container.decodeIfPresent(String.self, forKey: .eventFirstPlayerLogo)) ??
                                 (try? container.decodeIfPresent(String.self, forKey: .homeTeamLogo))
            
            awayParticipantLogo = (try? container.decodeIfPresent(String.self, forKey: .eventSecondPlayerLogo)) ??
                                 (try? container.decodeIfPresent(String.self, forKey: .awayTeamLogo))
        } else {
            homeParticipant = try container.decodeIfPresent(String.self, forKey: .eventHomeTeam)
            awayParticipant = try container.decodeIfPresent(String.self, forKey: .eventAwayTeam)
            homeParticipantKey = try container.decodeIfPresent(Int.self, forKey: .homeTeamKey)
            awayParticipantKey = try container.decodeIfPresent(Int.self, forKey: .awayTeamKey)
            
            homeParticipantLogo = (try? container.decodeIfPresent(String.self, forKey: .eventHomeTeamLogo)) ??
                                 (try? container.decodeIfPresent(String.self, forKey: .homeTeamLogo))
            
            awayParticipantLogo = (try? container.decodeIfPresent(String.self, forKey: .eventAwayTeamLogo)) ??
                                 (try? container.decodeIfPresent(String.self, forKey: .awayTeamLogo))
        }
    }
}

