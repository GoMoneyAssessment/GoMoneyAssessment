//
//  TodaysFixturesViewControllerUITests.swift
//  GoMoneyAssessmentUITests
//
//  Created by Danjuma Nasiru on 17/02/2025.
//

import XCTest

final class TodaysFixturesViewControllerUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testTableViewExists() throws {
            let tableView = app.tables.firstMatch
            XCTAssertTrue(tableView.exists, "TableView should be present on the screen")
        }
    
    func testLoaderIsVisibleWhileFetching() throws {
        let loader = app.activityIndicators["activityIndicator"]
        
        XCTAssertTrue(loader.exists, "Loader should be visible while fetching matches")
    }
    
    func testMatchesAreDisplayed() throws {
        let tableView = app.tables.firstMatch
        XCTAssertTrue(tableView.exists, "TableView should exist")

        let firstCell = tableView.cells.element(boundBy: 0)
        let exists = firstCell.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "First match cell should be displayed after data is loaded")
    }
    
//MARK: this test will pass if the API throws an error or if user reaches fetch limit before 30 seconds and API fails. An Error can be simulated by putting a wrong token in the network manager
//    func testErrorAlertIsDisplayed() throws {
//        let errorAlert = app.alerts.element(boundBy: 0)
//        XCTAssertTrue(errorAlert.waitForExistence(timeout: 30), "Error alert should appear when data fetching fails")
//
//        let retryButton = errorAlert.buttons["Retry"]
//        XCTAssertTrue(retryButton.exists, "Retry button should exist in the alert")
//        retryButton.tap()
//    }
}
