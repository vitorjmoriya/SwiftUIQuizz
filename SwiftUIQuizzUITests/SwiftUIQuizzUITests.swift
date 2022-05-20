//
//  SwiftUIQuizzUITests.swift
//  SwiftUIQuizzUITests
//
//  Created by Henrique Finger Zimerman on 20/05/22.
//

import XCTest
import iOSSnapshotTestCase
@testable import SwiftUIQuizz

class SwiftUIQuizzUITests: FBSnapshotTestCase {

    var app = XCUIApplication()

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        // recordMode = true
    }

    func launch() {
        app.launch()
    }

    func verifyView() {
        let image = app.screenshot().image.removingStatusBar
        FBSnapshotVerifyView(UIImageView(image: image))
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        launch()

        sleep(2)

        verifyView()
    }

    /*func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }*/
}
