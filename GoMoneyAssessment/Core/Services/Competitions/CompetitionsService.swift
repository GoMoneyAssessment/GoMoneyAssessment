//
//  CompetitionsService.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 12/02/2025.
//

import Foundation

protocol CompetitionsService {
    func fetchCompetitions() async throws -> CompetitionsResponse
    func fetchStandings(for code: String) async throws -> StandingsResponse
    func fetchFixtures(for code: String) async throws -> AllMatchesResponse
    func fetchTeams(for code: String) async throws -> TeamsResponse
}
