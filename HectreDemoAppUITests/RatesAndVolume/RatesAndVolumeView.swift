//
//  RatesAndVolumeView.swift
//  HectreDemoAppUITests
//
//  Created by Viajeros Lado B on 04/08/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//
import XCTest

struct RatesAndVolumeView {
    static let app = XCUIApplication()
    static let scrollView = app.scrollViews.firstMatch
    static let staffView =  app.otherElements["mainView"].otherElements["pruningView"].children(matching: .other).element(boundBy: 1).children(matching: .other).matching(identifier: "staffView").element(boundBy: 0)
    static let wagesButton = staffView.buttons["wages"]
    static let pieceRateButtonButton = staffView.buttons["pieceRate"]
    static let wagesLabel = staffView.staticTexts["wagesLabel"]
    static let pieceRateView = staffView.otherElements["pieceRateView"]

}
