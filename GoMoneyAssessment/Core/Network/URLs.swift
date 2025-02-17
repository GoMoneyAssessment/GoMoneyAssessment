//
//  URLs.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 12/02/2025.
//

import Foundation

enum URLs {
    case todayFixtures
    case competitions
    case standings(compCode: String)
    case competitionFixtures(compCode: String)
    case teams(compCode: String)
    
    var value: String {
        switch self {
        case .todayFixtures:
            URLs.baseUrl + "matches"
        case .competitions:
            URLs.baseUrl + "competitions"
        case .standings(let code):
            URLs.baseUrl + "competitions/\(code)/standings"
        case .competitionFixtures(let code):
            URLs.baseUrl + "competitions/\(code)/matches"
        case .teams(let code):
            URLs.baseUrl + "competitions/\(code)/teams"
        }
    }
    
    static let baseUrl: String = "https://api.football-data.org/v4/"
}
