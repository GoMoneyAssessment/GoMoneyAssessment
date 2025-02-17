//
//  SelectCompetitionFixturesViewModel.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 13/02/2025.
//

import Foundation

@MainActor
class SelectCompetitionFixturesViewModel: BaseViewModel {
    let service: CompetitionsService = CompetitionsServiceImpl()
    var competitionCode: String = ""
    var onFixturesFetched: (([Match]) -> ())?
    
    func fetchFixtures() {
        Task {
            do {
                let response = try await service.fetchFixtures(for: competitionCode)
                let fixtures = response.matches?.filter { match in
                    match.status?.lowercased() == "timed" || match.status?.lowercased() == "scheduled"
                }
                onFixturesFetched?(fixtures ?? [])
            } catch let error as AppError {
                print("error message is: \(error.message ?? "")")
                onErrorOccured?(error)
            }
        }
    }
}
