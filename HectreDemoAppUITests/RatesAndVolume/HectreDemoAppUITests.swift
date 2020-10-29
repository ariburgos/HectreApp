//
//  HectreDemoAppUITests.swift
//  HectreDemoAppUITests
//
//  Created by Viajeros Lado B on 01/08/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
// .

import XCTest

class RateAndVolumeUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false

         let ratesAndVolumeView = RatesAndVolumeView.self
        let _ = ratesAndVolumeView.staffView.waitForExistence(timeout: 0)
    }

    override func tearDown() {
    }

    func testShowAndHideRateType() {
        let app = XCUIApplication()
        app.launch()
        
        // GIVEN
        let ratesAndVolumeView = RatesAndVolumeView.self

        // WHEN
        ratesAndVolumeView.wagesButton.tap()
        // THEN
        assert(ratesAndVolumeView.wagesLabel.exists, "Wages button working")

        // WHEN
        ratesAndVolumeView.pieceRateButtonButton.tap()
        // THEN
        assert(ratesAndVolumeView.pieceRateView.exists, "Piece rate view displayed")
    }
}
