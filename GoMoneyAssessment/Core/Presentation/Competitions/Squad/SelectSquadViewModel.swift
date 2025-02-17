//
//  SelectSquadViewModel.swift
//  GoMoneyAssessment
//
//  Created by Danjuma Nasiru on 14/02/2025.
//

import Foundation

@MainActor
class SelectSquadViewModel: BaseViewModel {
    let service: CompetitionsService = CompetitionsServiceImpl()
    var onSquadFetched: (() -> ())?
    
}
