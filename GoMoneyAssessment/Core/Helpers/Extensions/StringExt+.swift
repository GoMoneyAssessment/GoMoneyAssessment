//
//  StringExt+.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 12/02/2025.
//

import Foundation

extension String {
    func getdateFromShortDateString() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let date = formatter.date(from: self)
        return date ?? Date()
    }
}
