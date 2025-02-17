//
//  AllCompetitionsViewModel.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 12/02/2025.
//

import Foundation

@MainActor
class AllCompetitionsViewModel {
    let competitionsService: CompetitionsService
    var onFetchCompetitions: (([Competition]) -> ())?
    init(competitionsService: CompetitionsService = CompetitionsServiceImpl()) {
        self.competitionsService = competitionsService
    }
    
    func fetchCompetitions() {
        Task {
            do {
                let response = try await competitionsService.fetchCompetitions()
                onFetchCompetitions?(response.competitions ?? [])
            } catch let error as AppError {
                print("error message is: \(error.message ?? "")")
            }
        }
    }

}
