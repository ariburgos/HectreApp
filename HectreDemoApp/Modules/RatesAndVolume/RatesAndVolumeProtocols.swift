//
//  RatesAndVolumeProtocols.swift
//  HectreDemoApp
//
//  Created by Viajeros Lado B on 01/08/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import Foundation

//MARK: Router -
protocol RatesAndVolumeRouterProtocol: class {

}
//MARK: Presenter -
protocol RatesAndVolumePresenterProtocol: class {
    func loadView()
    
    // Cell
    func updateRateType(for staffIndex: StaffIndex, rateType: RateType)
    func updateRateHour(for staffIndex: StaffIndex, rate: Float)
    func updateRateHourForAll(for staffIndex: StaffIndex, rate: Float)
    func countOfRowsInField(for staffIndex: StaffIndex) -> Int?
    func rowInField(for staffIndex: StaffIndex, rowIndex: Int) -> TreesForRowViewModel?
    func updateTapMaxTrees(jobType: JobType)
    func assignRowInField(for staffIndex: StaffIndex, rowIndex: Int)
    func removeRowInField(for staffIndex: StaffIndex, rowIndex: Int)
    func updateTreesForRow(staffIndex: StaffIndex, rowIndex: Int, value: Int)
    func confirmChanges()
}

//MARK: Interactor -
protocol RatesAndVolumeInteractorProtocol: class {
    var presenter: RatesAndVolumePresenterProtocol?  { get set }
    func requestTask(completionHandler: @escaping (Task?) -> ())
    func uploadChanges(task: Task)
}

//MARK: View -
protocol RatesAndVolumeViewProtocol: class {
    var presenter: RatesAndVolumePresenterProtocol?  { get set }
    func addStaffView(staffIndex: StaffIndex, staffViewModel: StaffViewModel)
    func setTressForRow(staffIndex: StaffIndex, rowIndex: Int, value: Int)
    func setRateHour(staffIndex: StaffIndex, rate: Float)
    func setRateHourForAll(jobType: JobType, rate: Float)
    func setRateType(for staffIndex: StaffIndex, rateType: RateType)
    func hidePruningView()
    func hideThiningView()
    func showMessage(message: String)
    func showLoading()
    func hideLoading()
}
