//
//  NetworkManager.swift
//  Sportify
//
//  Created by Abdelaziz on 02/06/2025.
//

import Foundation
import Reachability

class NetworkManager {
    static func isInternetAvailable() -> Bool {
        do {
            let reachability = try Reachability()
            return reachability.connection != Reachability.Connection.none
        } catch {
            print("Unable to create Reachability instanc")
            return false
        }
    }
}




