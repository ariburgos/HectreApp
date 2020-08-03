//
//  RatesAndVolumePresenterTests.swift
//  HectreDemoAppTests
//
//  Created by Viajeros Lado B on 03/08/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import XCTest
@testable import HectreDemoApp

class RatesAndVolumePresenterTests: XCTestCase {
    private var ratesAndVolumePresenter: RatesAndVolumePresenter!
    private var ratesAndVolumeView: RatesAndVolumeViewMock!
    private var ratesAndVolumeInteractor: RatesAndVolumeInteractorProtocol!
    
    func testFetchJobs() {
        givenARatesAndVolumeView()
        givenASuccessJobsInteractor()
        givenARatesAndVolumePresenter()

        whenPresenterLoadView()

        thenStaffViewIsDisplayed()
        thenAnLoadingIsDismissed()
    }
    
    func testEmptyJobs() {
        givenARatesAndVolumeView()
        givenAEmptyJobsInteractor()
        givenARatesAndVolumePresenter()
        
        whenPresenterLoadView()
        
        thenAnLoadingIsDismissed()
        thenAnHidePruningViewIsCalled()
        thenAnHideThiningViewIsCalled()
    }
    
    private func givenARatesAndVolumeView() {
        ratesAndVolumeView = RatesAndVolumeViewMock()
    }
    
    private func givenASuccessJobsInteractor() {
        ratesAndVolumeInteractor = SuccessJobsInteractorMock()
    }
    
    private func givenAEmptyJobsInteractor() {
        ratesAndVolumeInteractor = EmptyJobsInteractorMock()
    }
    
    private func givenARatesAndVolumePresenter() {
        ratesAndVolumePresenter = RatesAndVolumePresenter(interface: ratesAndVolumeView, interactor: ratesAndVolumeInteractor, router: RatesAndVolumeRouter())
    }
    
    private func whenPresenterLoadView() {
        ratesAndVolumePresenter.loadView()
    }

    private func thenStaffViewIsDisplayed() {
        XCTAssertTrue(ratesAndVolumeView.addStaffViewHasBeenCalled)
    }
    private func thenTressForRowIsCalled() {
        XCTAssertTrue(ratesAndVolumeView.setTressForRowHasBeenCalled)
    }
    private func thenAnRateHourIsCalled() {
        XCTAssertTrue(ratesAndVolumeView.setRateHourHasBeenCalled)
    }
    private func thenAnHidePruningViewIsCalled() {
        XCTAssertTrue(ratesAndVolumeView.hidePruningViewHasBeenCalled)
    }
    private func thenAnHideThiningViewIsCalled() {
        XCTAssertTrue(ratesAndVolumeView.hideThiningViewHasBeenCalled)
    }

    private func thenAnMessageIsDisplayed() {
        XCTAssertTrue(ratesAndVolumeView.showLoadingHasBeenCalled)
    }
    
    private func thenAnLoadingIsDisplayed() {
        XCTAssertTrue(ratesAndVolumeView.showMessageHasBeenCalled)
    }
    
    private func thenAnLoadingIsDismissed() {
        XCTAssertTrue(ratesAndVolumeView.hideLoadingBeenCalled)
    }
}

class SuccessJobsInteractorMock: NSObject, RatesAndVolumeInteractorProtocol {
    private(set) var uploadChangesHasBeenCalled: Bool = false

    func requestTask(completionHandler: @escaping (Task?) -> ()) {
        completionHandler(RatesAndVolumeMockResponses.jobsWithPruningAndThining)
    }
    
    func uploadChanges(task: Task) {
        uploadChangesHasBeenCalled = true
    }
    
    var presenter: RatesAndVolumePresenterProtocol?
}

class EmptyJobsInteractorMock: NSObject, RatesAndVolumeInteractorProtocol {
    private(set) var uploadChangesHasBeenCalled: Bool = false

    var presenter: RatesAndVolumePresenterProtocol?
    
    func requestTask(completionHandler: @escaping (Task?) -> ()) {
        completionHandler(nil)
    }
    
    func uploadChanges(task: Task) {
        uploadChangesHasBeenCalled = true
    }
}

class RatesAndVolumeViewMock: NSObject, RatesAndVolumeViewProtocol {
    var presenter: RatesAndVolumePresenterProtocol?
    
    
    private(set) var addStaffViewHasBeenCalled: Bool = false
    private(set) var setTressForRowHasBeenCalled: Bool = false
    private(set) var setRateHourForAllHasBeenCalled: Bool = false
    private(set) var setRateHourHasBeenCalled: Bool = false
    private(set) var setRateTypeHasBeenCalled: Bool = false
    private(set) var hidePruningViewHasBeenCalled: Bool = false
    private(set) var hideThiningViewHasBeenCalled: Bool = false
    private(set) var showLoadingHasBeenCalled: Bool = false
    private(set) var showMessageHasBeenCalled: Bool = false
    private(set) var hideLoadingBeenCalled: Bool = false
    
    
    func addStaffView(staffIndex: StaffIndex, staffViewModel: StaffViewModel) {
        addStaffViewHasBeenCalled = true
    }
    
    func setTressForRow(staffIndex: StaffIndex, rowIndex: Int, value: Int) {
        setTressForRowHasBeenCalled = true
    }
    
    func setRateHourForAll(jobType: JobType, rate: Float) {
        setRateHourForAllHasBeenCalled = true
    }
    
    func setRateHour(staffIndex: StaffIndex, rate: Float) {
        setRateHourHasBeenCalled = true
    }
    
    func setRateType(for staffIndex: StaffIndex, rateType: RateType) {
        setRateTypeHasBeenCalled = true
    }
    
    func hidePruningView() {
        hidePruningViewHasBeenCalled = true
    }
    
    func hideThiningView() {
        hideThiningViewHasBeenCalled = true
    }
    
    func showLoading() {
        showLoadingHasBeenCalled = true
    }

    func showMessage(message: String) {
        showMessageHasBeenCalled = true
    }
    
    func hideLoading() {
        hideLoadingBeenCalled = true
    }
}
