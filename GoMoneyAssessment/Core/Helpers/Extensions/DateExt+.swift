//
//  DateExt+.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 12/02/2025.
//

import Foundation

extension Date {
    func getTimeFromDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    func getYearCompFromDate() -> Int {
        let year = Calendar.current.component(.year, from: self)
        return year
    }
}
