//
//  DateAndTimeFormatter.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 12/02/2025.
//

import Foundation

final class DateAndTimeFormatter {
    static func getTimeFromDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        return formatter.string(from: date)
    }
}
