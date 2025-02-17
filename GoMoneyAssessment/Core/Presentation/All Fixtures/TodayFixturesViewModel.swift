//
//  TodayFixturesViewModel.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 12/02/2025.
//

import Foundation

@MainActor
class TodayFixturesViewModel: BaseViewModel {
    let allFixturesService: AllFixturesService
    var onFetchMatches: (([Match]) -> ())?
    init(allFixturesService: AllFixturesService = AllFixturesServiceImpl()) {
        self.allFixturesService = allFixturesService
    }
    
    func fetchTodaysMatches() {
        Task {
            do {
                let response = try await allFixturesService.fetchAllMatches()
                onFetchMatches?(response.matches ?? [])
            } catch let error as AppError {
                print("error message is: \(error.message ?? "")")
                onErrorOccured?(error)
            }
        }
    }
}
