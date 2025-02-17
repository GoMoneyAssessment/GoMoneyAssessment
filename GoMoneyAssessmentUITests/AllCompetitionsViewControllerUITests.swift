//
//  AllCompetitionsViewControllerUITests.swift
//  GoMoneyAssessmentUITests
//
//  Created by Danjuma Nasiru on 17/02/2025.
//

import XCTest

final class AllCompetitionsViewControllerUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        app.launch()
    }
    
    func testCompetitionsAreDisplayed() {
        let tabbar = app.tabBars.firstMatch
        
        tabbar.buttons["AllCompetitionsTab"].tap()
        
        let tableView = app.tables.firstMatch
        
        let firstCell = tableView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5), "First competition cell should exist after api call")
    }
    
    func testCompetitionSelectionNavigatesToNextScreen() {
        app.tabBars.buttons["AllCompetitionsTab"].tap()

        let tableView = app.tables.firstMatch

        let firstCell = tableView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5), "First competition cell should exist after api call")
        firstCell.tap()

        let button = app.buttons["Fixtures"]
        XCTAssertTrue(button.exists, "Screen successfully navigated to a select competition")
    }
}
