//
//  FakeNetworkService.swift
//  SportifyTests
//
//  Created by Abdelaziz on 04/06/2025.
//

import Foundation

@testable import Sportify

class FakeNetworkService{
    var shouldReturnError: Bool

    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }

    enum ResponseWithError: Error {
        case responseError
    }
}

extension FakeNetworkService {
    func fetchDataFromApi<T>(
        sport: String,
        met: String,
        from: String = "",
        to: String = "",
        leagueId: String = "",
        teamId: String = "",
        handler: @escaping ([T]?) -> Void
    ) where T : Decodable {
        if shouldReturnError {
            handler(nil)
        } else {
            
            handler([])
        }
    }
}


