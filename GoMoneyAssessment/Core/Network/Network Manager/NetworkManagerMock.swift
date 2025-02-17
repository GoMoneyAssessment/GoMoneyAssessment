//
//  NetworkManagerMock.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 16/02/2025.
//

import Foundation

class NetworkManagerMock: NetworkManager {
    var requestHandler: RequestHandler
    var responsehandler: ResponseHandler
    var shouldThrowError: Bool?
    var mockResponse: Any?
    
    init(requestHandler: RequestHandler = RequestHandlerMock(), responsehandler: ResponseHandler = ResponseHandlerMock()) {
        self.requestHandler = requestHandler
        self.responsehandler = responsehandler
    }
    
    func get<T: Codable>(urlString: String) async throws -> T {
        if shouldThrowError ?? false {
            throw AppError(code: 400, message: "bad request")
        } else {
            if let mockResponse = mockResponse as? T {
                return mockResponse
            } else {
                throw AppError(code: 400, message: "something wrong")
            }
        }
    }
}
