//
//  Team.swift
//  Sportify
//
//  Created by Abdelaziz on 30/05/2025.
//

import Foundation


struct Team: Decodable {
    let teamKey: Int
    let teamName: String?
    let teamLogo: String?
    let players: [Player]?
    let coaches : [Coach]?

    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players, coaches
    }
}

struct Coach: Decodable {
    let coachName: String
    let coachCountry, coachAge: String?

    enum CodingKeys: String, CodingKey {
        case coachName = "coach_name"
        case coachCountry = "coach_country"
        case coachAge = "coach_age"
    }
}

struct Player: Decodable {
    let playerKey: Int
    let playerImage: String?
    let playerName, playerNumber: String?
    let playerCountry: String?
    let playerType: PlayerType
    let playerAge, playerMatchPlayed, playerGoals: String?
    let playerRating: String?

    enum CodingKeys: String, CodingKey {
        case playerKey = "player_key"
        case playerImage = "player_image"
        case playerName = "player_name"
        case playerNumber = "player_number"
        case playerCountry = "player_country"
        case playerType = "player_type"
        case playerAge = "player_age"
        case playerMatchPlayed = "player_match_played"
        case playerGoals = "player_goals"
        case playerRating = "player_rating"
    }
}


enum PlayerType: String, Decodable {
    case defenders = "Defenders"
    case forwards = "Forwards"
    case goalkeepers = "Goalkeepers"
    case midfielders = "Midfielders"
}
