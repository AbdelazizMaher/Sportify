//
//  NetworkService.swift
//  Sportify
//
//  Created by Ali_Kotb on 30/05/2025.
//

import Foundation
import Alamofire

protocol PNetworkService{
    func fetchDataFromApi<T: Decodable>(
        sport: String,
        met: String,
        from: String,
        to: String,
        leagueId: String ,
        handler: @escaping ([T]?) -> Void
    )
}

class NetworkServiceCM : PNetworkService{
    func fetchDataFromApi<T: Decodable>(
        sport: String,
        met: String,
        from: String = "",
        to: String = "",
        leagueId: String = "",
        handler: @escaping ([T]?) -> Void
    ) {
        var url = "\(URL)\(sport)/?met=\(met)&APIkey=\(API_KEY)&from=\(from)&to=\(to)"
        
        if !leagueId.isEmpty {
            url += "&leagueId=\(leagueId)"
        }
        
        AF.request(url).responseDecodable(of: APIResponse<T>.self) { response in
            switch response.result {
            case .success(let apiResponse):
                handler(apiResponse.result)
            case .failure(let error):
                print("Error fetching data: \(error)")
                handler(nil)
            }
        }
    }
}
