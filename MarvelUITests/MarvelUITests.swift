//
//  MarvelUITests.swift
//  MarvelUITests
//
//  Created by Leandro Hernandez on 17/3/22.
//

import XCTest

class MarvelUITests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
}

//
extension MarvelUITests {
    
    //
    func testDetailAndBackNavigation() throws {

        // launch app
        let app = XCUIApplication()
        app.launch()
        
        // detail navigation
        XCUIApplication().tables.cells.containing(.staticText, identifier: "3-D Man").children(matching: .other).element(boundBy: 0).tap()
                                        
        // back navigation
        app.navigationBars["Character"].buttons["Back"].tap()
    }
    
    //
    func testMainViewItems() throws {

        // launch app
        let app = XCUIApplication()
        app.launch()
        
        // then
        XCTAssert(app.staticTexts["MOST POPULARS"].exists, "UIElement not found")
        XCTAssert(app.staticTexts["CHARACTERS"].exists, "UIElement not found")
    }
    
    //
    func testDetailViewItems() throws {

        // launch app
        let app = XCUIApplication()
        app.launch()
                      
        // when: detail navigation
        app.tables.cells.containing(.staticText, identifier: "3-D Man").element.tap()
        
        // then
        XCTAssert(app.navigationBars["Character"].exists, "UIElement not found")
        XCTAssert(app.staticTexts["3-D Man"].exists, "UIElement not found")
        XCTAssert(app.staticTexts["Comics collection"].exists, "UIElement not found")
        XCTAssert(app.staticTexts["Series"].exists, "UIElement not found")
        XCTAssert(app.staticTexts["Stories"].exists, "UIElement not found")
    }
}

// MARK: - Performance Methods
extension MarvelUITests {
    
    //
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
