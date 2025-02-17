//
//  AllFixturesServiceImpl.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 12/02/2025.
//

import Foundation

struct AllFixturesServiceImpl: AllFixturesService {
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManagerImpl()) {
        self.networkManager = networkManager
    }
    
    func fetchAllMatches() async throws -> AllMatchesResponse {
        let response: AllMatchesResponse = try await networkManager.get(urlString: URLs.todayFixtures.value)
        return response
    }
}
