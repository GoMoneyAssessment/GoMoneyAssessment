//
//  CompetitionsServiceImpl.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 12/02/2025.
//

import Foundation

class CompetitionsServiceImpl: CompetitionsService {
    
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManagerImpl()) {
        self.networkManager = networkManager
    }

    func fetchCompetitions() async throws -> CompetitionsResponse {
        let response: CompetitionsResponse = try await networkManager.get(urlString: URLs.competitions.value)
        return response
    }
    
    func fetchStandings(for code: String) async throws -> StandingsResponse {
        let response: StandingsResponse = try await networkManager.get(urlString: URLs.standings(compCode: code).value)
        return response
    }
    
    func fetchFixtures(for code: String) async throws -> AllMatchesResponse {
        let response: AllMatchesResponse = try await networkManager.get(urlString: URLs.competitionFixtures(compCode: code).value)
        return response
    }
    
    func fetchTeams(for code: String) async throws -> TeamsResponse {
        let response: TeamsResponse = try await networkManager.get(urlString: URLs.teams(compCode: code).value)
        return response
    }
}
