//
//  ResponseHandlerMock.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 16/02/2025.
//

import Foundation

class ResponseHandlerMock: ResponseHandler {
    
    func decodeData<T: Codable>(statusCode: Int, data: Data) throws -> T {
        let decoder = JSONDecoder()
        switch statusCode {
        case 200...299:
            do {
                let response = try? decoder.decode(T.self, from: data)
                if let response {
                    return response
                } else {
                    throw AppError(code: statusCode, message: "Mock decoding failed")
                }
            }
        case 400...499:
            let returnedError = try? decoder.decode(AppError.self, from: data)
            if let returnedError {
                throw returnedError
            } else {
                throw AppError(code: statusCode, message: "Mock decoding failed")
            }
        case 500...599:
            throw AppError(code: statusCode, message: "Server Unavailable")
        default:
            throw AppError(code: statusCode, message: "Something went wrong")
        }
    }
}
