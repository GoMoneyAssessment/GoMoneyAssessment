//
//  RequestHandlerImpl.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 16/02/2025.
//

import Foundation

class RequestHandlerImpl: RequestHandler {
    func makeRequest(request: URLRequest) async throws -> (Int, Data) {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse else { throw URLError(.badServerResponse) }
        if let stringData = String(data: data, encoding: .utf8) {
            print("Raw Response Data with status code: \(response.statusCode)")
            print(stringData)
        }
        return (response.statusCode, data)
    }
}
