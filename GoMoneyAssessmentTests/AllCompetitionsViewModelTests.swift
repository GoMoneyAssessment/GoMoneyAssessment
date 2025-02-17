//
//  AllCompetitionsViewModelTests.swift
//  GoMoneyAssessmentTests
//
//  Created by Danjuma Nasiru on 16/02/2025.
//

import XCTest
@testable import GoMoneyAssessment

@MainActor
final class AllCompetitionsViewModelTests: XCTestCase {
    
    var viewModel: AllCompetitionsViewModel!
    var mockService: CompetitionsService!
    
    override func setUp() {
        super.setUp()
        mockService = CompetitionsServiceMock()
        viewModel = AllCompetitionsViewModel(competitionsService: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testFetchCompetitions_Success() async {
        let service = mockService as! CompetitionsServiceMock
        let expectedCompetitions: [Competition] = [Competition(id: 12, area: nil, name: "Premier League", code: nil, type: nil, emblem: nil, plan: nil, currentSeason: nil, numberOfAvailableSeasons: nil, lastUpdated: nil)]
        service.mockResponse = CompetitionsResponse(count: 1, filters: nil, competitions: expectedCompetitions)
        
        let expectation = XCTestExpectation(description: "Competitions fetched successfully")
        
        viewModel.onFetchCompetitions = { competitions in
            XCTAssertEqual(competitions.count, 1)
            XCTAssertEqual(competitions.first?.name, "Premier League")
            expectation.fulfill()
        }
        
        viewModel.fetchCompetitions()
        
        await fulfillment(of: [expectation], timeout: 1.0)
    }
    
    func testFetchCompetitions_Failure() async {
        let service = mockService as! CompetitionsServiceMock
        service.mockError = AppError(code: 400, message: "competitions cannot be fetched")
        
        let expectation = XCTestExpectation(description: "competitions cannot be fetched")
        
        viewModel.onErrorOccured = { error in
            XCTAssertEqual(error.message, "competitions cannot be fetched")
            expectation.fulfill()
        }
        
        viewModel.fetchCompetitions()
        
        await fulfillment(of: [expectation], timeout: 10.0)
    }
}
