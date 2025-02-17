//
//  NetworkManager.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 12/02/2025.
//

import Foundation

class NetworkManager {
    let header: [String : String] = [
        "X-Auth-Token" : "2c1b9cf006304d8bbc0afefa361827cd"
    ]
    let requestHandler: RequestHandler
    let responsehandler: ResponseHandler
    
    init(requestHandler: RequestHandler = RequestHandlerImpl(), responsehandler: ResponseHandler = ResponseHandlerImpl()) {
        self.requestHandler = requestHandler
        self.responsehandler = responsehandler
    }
    
    func get<T: Codable>(urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw AppError(code: nil, message: "invalid url")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = header
        
        let (code, data) = try await requestHandler.makeRequest(request: request)
        
        let response: T = try responsehandler.decodeData(statusCode: code, data: data)
        return response
    }
}
