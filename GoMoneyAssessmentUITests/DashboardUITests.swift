//
//  DashboardUITests.swift
//  GoMoneyAssessmentUITests
//
//  Created by Danjuma Nasiru on 17/02/2025.
//

import XCTest

final class DashboardUITests: XCTestCase {

    var app: XCUIApplication!
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testTabbarExists() throws {
        let tabbar = app.tabBars.firstMatch
        XCTAssertTrue(tabbar.exists, "Tabbar should be present")
    }
    
    func testTodaysFixturesTabExists() throws {
        let tabbar = app.tabBars.firstMatch
        let todaysFixtures = tabbar.buttons.element(boundBy: 0)
        XCTAssertTrue(todaysFixtures.exists, "Today's fixtures tab exists")
    }
    
    func testCompetitionsTabExists() throws {
        let tabbar = app.tabBars.firstMatch
        
        let allCompetitionsTab = tabbar.buttons.element(boundBy: 1)
        XCTAssertTrue(allCompetitionsTab.exists, "Today's fixtures tab exists")
    }
    
    func testSwitchTabs() throws {
        let tabBar = app.tabBars.firstMatch
        
        let todaysFixturesTab = tabBar.buttons.element(boundBy: 0)
        let allCompetitionsTab = tabBar.buttons.element(boundBy: 1)
        
        todaysFixturesTab.tap()
        XCTAssertTrue(app.navigationBars["Today's Fixtures"].exists, "Should be on Today Fixtures screen")
        
        allCompetitionsTab.tap()
        XCTAssertTrue(app.navigationBars["Competitions"].exists, "Should be on All Competitions screen")
    }
}
