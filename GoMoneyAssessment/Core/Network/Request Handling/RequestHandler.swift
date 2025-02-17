//
//  RequestHandler.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 16/02/2025.
//

import Foundation

protocol RequestHandler {
    func makeRequest(request: URLRequest) async throws -> (Int, Data)
}
