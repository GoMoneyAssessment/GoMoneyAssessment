//
//  CompetitionsResponse.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 12/02/2025.
//

import Foundation

struct CompetitionsResponse: Codable {
    let count: Int?
    let filters: Filters?
    let competitions: [Competition]?
}
