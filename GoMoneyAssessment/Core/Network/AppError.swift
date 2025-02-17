//
//  AppError.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 12/02/2025.
//

import Foundation

struct AppError: Codable, Error {
    let code: Int?
    let message: String?
}
