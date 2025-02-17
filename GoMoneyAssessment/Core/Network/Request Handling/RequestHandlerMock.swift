//
//  RequestHandlerMock.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 16/02/2025.
//

import Foundation

class RequestHandlerMock: RequestHandler {
    var mockStatusCode: Int?
    var mockData: Data?
    var shouldThrowError: Bool?
    
    func makeRequest(request: URLRequest) async throws -> (Int, Data) {
        if shouldThrowError ?? false {
            throw URLError(.notConnectedToInternet)
        }
        return (mockStatusCode ?? 200, mockData ?? Data())
    }
}
