//
//  ApiResponse.swift
//  Sportify
//
//  Created by Abdelaziz on 30/05/2025.
//

import Foundation

struct APIResponse<T: Decodable>: Decodable {
    let success: Int
    let result: [T]?
}
