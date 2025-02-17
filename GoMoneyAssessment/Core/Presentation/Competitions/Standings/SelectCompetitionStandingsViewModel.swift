//
//  SelectCompetitionStandingsViewModel.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 13/02/2025.
//

import Foundation

@MainActor
class SelectCompetitionStandingsViewModel: BaseViewModel {
    let service: CompetitionsService = CompetitionsServiceImpl()
    var competitionCode: String = ""
    var onStandingsFetched: (([Standing])->())?
    
    func fetchStandings() {
        Task {
            do {
                let response = try await service.fetchStandings(for: competitionCode)
                onStandingsFetched?(response.standings ?? [])
            } catch let error as AppError {
                onErrorOccured?(error)
            }
        }
    }
}
