//
//  CompetitionsServiceMock.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 16/02/2025.
//

import Foundation

class CompetitionsServiceMock: CompetitionsService {
    
    var mockResponse: Any?
    var mockError: AppError?
    
    func fetchCompetitions() async throws -> CompetitionsResponse {
        if let mockError {
            throw mockError
        }
        if let mockResponse = mockResponse as? CompetitionsResponse {
            return mockResponse
        }
        throw AppError(code: 400, message: "uncatered")
    }
    
    func fetchStandings(for code: String) async throws -> StandingsResponse {
        if let mockError {
            throw mockError
        }
        if let mockResponse = mockResponse as? StandingsResponse {
            return mockResponse
        }
        throw AppError(code: 400, message: "uncatered")
    }
    
    func fetchFixtures(for code: String) async throws -> AllMatchesResponse {
        if let mockError {
            throw mockError
        }
        if let mockResponse = mockResponse as? AllMatchesResponse {
            return mockResponse
        }
        throw AppError(code: 400, message: "uncatered")
    }
    
    func fetchTeams(for code: String) async throws -> TeamsResponse {
        if let mockError {
            throw mockError
        }
        if let mockResponse = mockResponse as? TeamsResponse {
            return mockResponse
        }
        throw AppError(code: 400, message: "uncatered")
    }
    
    
}
