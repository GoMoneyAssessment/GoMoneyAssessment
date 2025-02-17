//
//  ResponseHandlerImpl.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 16/02/2025.
//

import Foundation

class ResponseHandlerImpl: ResponseHandler {
    func decodeData<T: Codable>(statusCode: Int, data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        switch statusCode {
        case 200...299:
            do {
                let response = try? decoder.decode(T.self, from: data)
                if let response {
                    return response
                } else {
                    throw AppError(code: statusCode, message: "Data could not be read")
                }
            }
        case 400...499:
            let returnedError = try? decoder.decode(AppError.self, from: data)
            if let returnedError {
                throw returnedError
            } else {
                throw AppError(code: statusCode, message: "Data could not be read")
            }
        case 500...599:
            throw AppError(code: statusCode, message: "Server Unavailable")
        default:
            print("Unhandled status code: \(statusCode)")
            throw AppError(code: statusCode, message: "Something went wrong")
        }
    }
}
