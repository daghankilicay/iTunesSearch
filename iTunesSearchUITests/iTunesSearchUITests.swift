//
//  iTunesSearchUITests.swift
//  iTunesSearchUITests
//
//  Created by Dağhan Kılıçay on 19.01.2021.
//

import XCTest
@testable import iTunesSearch
import Alamofire
class iTunesSearchUITests: XCTestCase {

    func testUI() throws {
        let app = XCUIApplication()
        let collectionView = app.collectionViews
        let searchField = app.searchFields.element(boundBy: 0)
        let firstChild = collectionView.children(matching:.any).element(boundBy: 0)
        
        app.launch()
        
        searchField.tap()
        searchField.typeText("Love")
        app.keyboards.buttons["Search"].tap()
        
        sleep(2)
        
        app.buttons["Musics"].tap()
        
        sleep(1)
        
        app.buttons["Books"].tap()
        
        sleep(1)
        
        app.buttons["Movies"].tap()
        
        sleep(1)
        
        if firstChild.exists {
             firstChild.tap()
        }
        
        sleep(2)
        
        app.navigationBars.buttons.element(boundBy: 0).tap()
                
        sleep(1)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
