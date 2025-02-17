//
//  CompetitionsServiceTests.swift
//  GoMoneyAssessmentTests
//
//  Created by Danjuma Nasiru on 16/02/2025.
//

import XCTest
@testable import GoMoneyAssessment

final class CompetitionsServiceTests: XCTestCase {

    var service: CompetitionsService!
    var networkManager: NetworkManager!

    override func setUp() {
        super.setUp()
        networkManager = NetworkManagerMock(requestHandler: RequestHandlerMock(), responsehandler: ResponseHandlerMock())
        service = CompetitionsServiceImpl(networkManager: networkManager)
    }
    
    override func tearDown() {
        service = nil
        networkManager = nil
        super.tearDown()
    }
    
    func testFetchCompetitions_Success() async {
        let manager = networkManager as! NetworkManagerMock
        manager.mockResponse = CompetitionsResponse(count: 1, filters: nil, competitions: [])
        
        do {
            let response = try await service.fetchCompetitions()
            XCTAssertEqual(response.competitions?.count, 0)
        } catch {
            XCTFail()
        }
    }
    
    func testFetchCompetitions_Failure() async {
        let manager = networkManager as! NetworkManagerMock
        manager.shouldThrowError = true
        
        do {
            let _ = try await service.fetchCompetitions()
            XCTFail("it should have enter catch block")
        } catch let error as AppError {
            XCTAssertEqual(error.message, "bad request")
        } catch {
            XCTFail()
        }
    }
}
