//
//  SelectCompetitionTeamsViewModel.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 13/02/2025.
//

import Foundation

@MainActor
class SelectCompetitionTeamsViewModel: BaseViewModel {
    let service: CompetitionsService = CompetitionsServiceImpl()
    var competitionCode: String = ""
    var onTeamsFetched: (([Team]) -> ())?
    
    func fetchTeams() {
        Task {
            do {
                let response = try await service.fetchTeams(for: competitionCode)
                onTeamsFetched?(response.teams ?? [])
            } catch let error as AppError {
                print("error message is: \(error.message ?? "")")
                onErrorOccured?(error)
            }
        }
    }
}
