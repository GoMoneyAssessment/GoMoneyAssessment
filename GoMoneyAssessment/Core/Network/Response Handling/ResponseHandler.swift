//
//  ResponseHandler.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 16/02/2025.
//

import Foundation

protocol ResponseHandler {
    func decodeData<T: Codable>(statusCode: Int, data: Data) throws -> T 
}
