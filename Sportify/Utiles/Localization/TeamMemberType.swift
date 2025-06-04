//
//  TeamMemberType.swift
//  Sportify
//
//  Created by Ali_Kotb on 04/06/2025.
//

import Foundation

func getTeamMemberType(member: PlayerType) -> String {
    switch member {
    case .defenders:
        return NSLocalizedString("defender", comment: "hamda")
    case .forwards:
        return NSLocalizedString("foreard", comment: "hamda")
    case .goalkeepers:
        return NSLocalizedString("goolkeper", comment: "hamda")
    case .midfielders:
        return NSLocalizedString("Midfielders", comment: "hamda")
    }
}
