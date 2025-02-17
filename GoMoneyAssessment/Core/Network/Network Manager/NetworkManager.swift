//
//  NetworkManager.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 12/02/2025.
//

import Foundation

protocol NetworkManager {
    var requestHandler: RequestHandler {get set}
    var responsehandler: ResponseHandler {get set}
    
    func get<T: Codable>(urlString: String) async throws -> T
}
