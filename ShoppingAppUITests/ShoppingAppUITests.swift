//
//  ShoppingAppUITests.swift
//  ShoppingAppUITests
//
//  Created by Erdem Perşembe on 12.04.2022.
//

import XCTest

class ShoppingAppUITests: XCTestCase {
    
    //Before testing please empty your shopping cart.
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        let collectionViewsQuery = app.collectionViews
        let cell = collectionViewsQuery.cells.containing(.staticText, identifier:"7.5₺").children(matching: .other).element.children(matching: .other).element(boundBy: 0)
        XCTAssertTrue(cell.exists)
        cell.tap()
        
        let add = app.buttons["add"]
        XCTAssertTrue(add.exists)
        add.tap()
        
        let update = app/*@START_MENU_TOKEN@*/.buttons["Update Cart 7.50₺"].staticTexts["Update Cart 7.50₺"]/*[[".buttons[\"Update Cart 7.50₺\"].staticTexts[\"Update Cart 7.50₺\"]",".staticTexts[\"Update Cart 7.50₺\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        XCTAssertTrue(update.exists)
        update.tap()
        
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Total Amount 7.50₺"]/*[[".buttons[\"Total Amount 7.50₺\"].staticTexts[\"Total Amount 7.50₺\"]",".staticTexts[\"Total Amount 7.50₺\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables.buttons["Checkout: 7.50₺"].tap()
        app.alerts["Checkout completed 7.50₺"].scrollViews.otherElements.buttons["OK"].tap()

        let cell2 = collectionViewsQuery.cells.containing(.staticText, identifier:"14.0₺").children(matching: .other).element.children(matching: .other).element(boundBy: 0)
        XCTAssertTrue(cell2.exists)
        cell2.tap()

        add.tap()
        
        let update2 = app.buttons["Update Cart 14.00₺"].staticTexts["Update Cart 14.00₺"]
        XCTAssertTrue(update2.exists)
        update2.tap()
        
        collectionViewsQuery.staticTexts["Total Amount 14.00₺"].tap()
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Backhaus Koko Kurabiyesi"]/*[[".cells.staticTexts[\"Backhaus Koko Kurabiyesi\"]",".staticTexts[\"Backhaus Koko Kurabiyesi\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeLeft(velocity: .fast)
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Delete"]/*[[".cells.buttons[\"Delete\"]",".buttons[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
