//
//  TeamsResponse.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 13/02/2025.
//

import Foundation

struct TeamsResponse: Codable {
    let count: Int?
    let filters: Filters?
    let competition: Competition?
    let season: Season?
    let teams: [Team]?
}
