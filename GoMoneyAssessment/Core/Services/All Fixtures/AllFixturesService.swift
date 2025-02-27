//
//  AllFixturesService.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 12/02/2025.
//

import Foundation

protocol AllFixturesService {
    func fetchAllMatches() async throws -> AllMatchesResponse
}
