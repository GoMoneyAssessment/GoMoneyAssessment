//
//  AllMatchesResponse.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 12/02/2025.
//

import Foundation

struct AllMatchesResponse: Codable {
    let filters: Filters?
    let resultSet: ResultSet?
    let matches: [Match]?
}

struct Filters: Codable {
    let dateFrom: String?
    let dateTo: String?
    let permission: String?
    let client: String?
    let season: String?
}

struct ResultSet: Codable {
    let count: Int?
    let competitions: String?
    let first: String?
    let last: String?
    let played: Int?
}

struct Match: Codable {
    let area: Area?
    let competition: Competition?
    let season: Season?
    let id: Int?
    let utcDate: Date?
    let status: String?
    let matchday: Int?
    let stage: String?
    let group: String?
    let lastUpdated: String?
    let homeTeam: Team?
    let awayTeam: Team?
    let score: Score?
    let elapsedTime: String?
    let odds: Odds?
    let referees: [Referee]?
}

struct Area: Codable {
    let id: Int?
    let name: String?
    let code: String?
    let flag: String?
}

struct Competition: Codable {
    let id: Int?
    let area: Area?
    let name: String?
    let code: String?
    let type: String?
    let emblem: String?
    let plan: String?
    let currentSeason: Season?
    let numberOfAvailableSeasons: Int?
    let lastUpdated: String?
}

struct Season: Codable {
    let id: Int?
    let startDate: String?
    let endDate: String?
    let currentMatchday: Int?
    let winner: Team?
}

struct Team: Codable {
    let id: Int?
    let name: String?
    let shortName: String?
    let tla: String?
    let crest: String?
    let address: String?
    let website: String?
    let founded: Int?
    let clubColors: String?
    let venue: String?
    let runningCompetitions: [Competition]?
    let coach: Coach?
    let squad: [Player]?
    let lastUpdated: String?
}

struct Score: Codable {
    let winner: String?
    let duration: String?
    let fullTime: ScoreDetail?
    let halfTime: ScoreDetail?
}

struct ScoreDetail: Codable {
    let home: Int?
    let away: Int?
}

struct Odds: Codable {
    let msg: String?
}

struct Coach: Codable {
    let id: Int?
    let firstName: String?
    let lastName: String?
    let name: String?
    let dateOfBirth: String?
    let nationality: String?
    let contract: Contract?
}

struct Contract: Codable {
    let start: String?
    let until: String?
}

struct Player: Codable {
    let id: Int?
    let name: String?
    let position: String?
    let dateOfBirth: String?
    let nationality: String?
}

struct Referee: Codable {
    let id: Int?
    let name: String?
    let type: String?
    let nationality: String?
}
