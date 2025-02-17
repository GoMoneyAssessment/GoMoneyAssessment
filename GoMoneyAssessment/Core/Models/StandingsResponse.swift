//
//  StandingsResponse.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 13/02/2025.
//

import Foundation

struct StandingsResponse: Codable {
    let filters: Filters?
    let area: Area?
    let competition: Competition?
    let season: Season?
    let standings: [Standing]?
}

struct Standing: Codable {
    let stage: String?
    let type: String?
    let group: String?
    let table: [TeamStanding]?
}

struct TeamStanding: Codable {
    let position: Int?
    let team: Team?
    let playedGames: Int?
    let form: String?
    let won: Int?
    let draw: Int?
    let lost: Int?
    let points: Int?
    let goalsFor: Int?
    let goalsAgainst: Int?
    let goalDifference: Int?
}

