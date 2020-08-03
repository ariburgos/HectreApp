//
//  RatesAndVolumePresenter.swift
//  HectreDemoApp
//
//  Created by Viajeros Lado B on 01/08/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import UIKit
typealias NameModel = (firstName: String, lastName: String)
typealias StaffViewModel = (name: NameModel, orchard: String, block: String)
typealias StaffIndex = (jobType: JobType, row: Int)

class RatesAndVolumePresenter: RatesAndVolumePresenterProtocol {
    weak private var view: RatesAndVolumeViewProtocol?
    private let interactor: RatesAndVolumeInteractorProtocol
    private let router: RatesAndVolumeRouterProtocol
    
    private var task: Task?
    
    init(interface: RatesAndVolumeViewProtocol, interactor: RatesAndVolumeInteractorProtocol, router: RatesAndVolumeRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func loadView() {
        ErrorManager.dropBreadCrumb(breadCrumb: "Load view")

        view?.showLoading()
        interactor.requestTask {[weak self] (task) in
            self?.task = task
            
            if let pruning = task?.pruning {
                for i in 0 ..< pruning.staff.count {
                    let staffVM = StaffViewModel(name: (firstName: pruning.staff[i].firstName, lastName: pruning.staff[i].lastName), orchard: pruning.orchard, block: pruning.block )
                    let staffIndex = StaffIndex(jobType: .pruning, row: i)
                    self?.view?.addStaffView(staffIndex: staffIndex, staffViewModel: staffVM)
                    self?.view?.setRateHour(staffIndex: staffIndex, rate: pruning.staff[i].rateHour)
                    self?.view?.setRateType(for: staffIndex, rateType: pruning.staff[i].rateType)
                }
            } else {
                self?.view?.hidePruningView()
            }
            
            if let thining = task?.thining {
                for i in 0 ..< thining.staff.count {
                    let staffVM = StaffViewModel(name: (firstName: thining.staff[i].firstName, lastName: thining.staff[i].lastName), orchard: thining.orchard, block: thining.block )
                    let staffIndex = StaffIndex(jobType: .thining, row: i)
                    self?.view?.addStaffView(staffIndex: staffIndex, staffViewModel: staffVM)
                    self?.view?.setRateHour(staffIndex: staffIndex, rate: thining.staff[i].rateHour)
                    self?.view?.setRateType(for: staffIndex,  rateType:thining.staff[i].rateType)
                }
            } else {
                self?.view?.hideThiningView()
            }
            self?.view?.hideLoading()
        }
    }
    
    func updateRateType(for staffIndex: StaffIndex, rateType: RateType) {
        ErrorManager.dropBreadCrumb(breadCrumb: "Update rate type")

        switch staffIndex.jobType {
        case .pruning:
            task?.pruning?.staff[staffIndex.row].rateType = rateType
        case .thining:
            task?.thining?.staff[staffIndex.row].rateType = rateType
        }
    }
    
    func updateRateHour(for staffIndex: StaffIndex, rate: Float) {
        ErrorManager.dropBreadCrumb(breadCrumb: "Update rate hour")

        switch staffIndex.jobType {
        case .pruning:
            task?.pruning?.staff[staffIndex.row].rateHour = rate
            
        case .thining:
            task?.thining?.staff[staffIndex.row].rateHour = rate
        }
    }
    
    func updateRateHourForAll(for staffIndex: StaffIndex, rate: Float) {
        ErrorManager.dropBreadCrumb(breadCrumb: "Update rate hour for all")

        switch staffIndex.jobType {
        case .pruning:
            if let pruning = task?.pruning {
                for i in 0..<pruning.staff.count {
                    task?.pruning?.staff[i].rateHour = rate
                    view?.setRateHourForAll(jobType: .pruning, rate: rate)
                }
            }
        case .thining:
            if let thining = task?.thining {
                for i in 0..<thining.staff.count {
                    task?.thining?.staff[i].rateHour = rate
                    view?.setRateHourForAll(jobType: .thining, rate: rate)
                }
            }
        }
    }
    
    func countOfRowsInField(for staffIndex: StaffIndex) -> Int? {
        ErrorManager.dropBreadCrumb(breadCrumb: "Count row in field")

        switch staffIndex.jobType {
        case .pruning:
            if let pruning = task?.pruning {
                return pruning.rowsInField.count
            }
        case .thining:
            if let thining = task?.thining {
                return thining.rowsInField.count
            }
        }
        return 0
    }
    
    func rowInField(for staffIndex: StaffIndex, rowIndex: Int) -> TreesForRowViewModel? {
        ErrorManager.dropBreadCrumb(breadCrumb: "Row in field for")

        switch staffIndex.jobType {
        case .pruning:
            if let pruning = task?.pruning {
                //maxValue: pruning.rowsInField[rowIndex.row].jobsDone.compactMap({$0.completed}).reduce(0, +)
                return (id: pruning.rowsInField[rowIndex].id,
                        completed: 0,
                        maxValue: pruning.rowsInField[rowIndex].amountToDo,
                        completedJobs: pruning.rowsInField[rowIndex].jobsDone.compactMap({ "\($0.name) (\($0.completed))" }),
                        isSelected: pruning.staff[staffIndex.row].asignedRows.contains(where: { $0.asignedRow == pruning.rowsInField[rowIndex]}) )
            }
        case .thining:
            if let thining = task?.thining {
                return (id: thining.rowsInField[rowIndex].id,
                        completed: 0,
                        maxValue: thining.rowsInField[rowIndex].amountToDo,
                        completedJobs: thining.rowsInField[rowIndex].jobsDone.compactMap({ "\($0.name) (\($0.completed))" }),
                        isSelected: thining.staff[staffIndex.row].asignedRows.contains(where: { $0.asignedRow == thining.rowsInField[rowIndex]}))
            }
        }
        return nil
    }
    
    func updateTapMaxTrees(jobType: JobType) {
        ErrorManager.dropBreadCrumb(breadCrumb: "Update max trees")

        switch jobType {
        case .pruning:
            if let pruning = task?.pruning {
                var rowIndex = 0
                pruning.rowsInField.forEach { (rowInField) in
                    let staffAsignedRow = pruning.staff.filter({ (staff) -> Bool in
                        staff.asignedRows.contains { (asignedRow) -> Bool in
                            asignedRow.asignedRow == rowInField
                        }
                    })
                    if staffAsignedRow.count > 0 {
                        let completed = rowInField.jobsDone.compactMap({$0.completed}).reduce(0, +)
                        
                        let splitedTrees = (rowInField.amountToDo - completed)/staffAsignedRow.count
                        for i in 0..<pruning.staff.count {
                            if pruning.staff[i].asignedRows.contains(where: { (assignedRow) -> Bool in
                                assignedRow.asignedRow == rowInField
                            }) {
                                let staffIndex = StaffIndex(jobType: .pruning, row: i)
                                view?.setTressForRow(staffIndex: staffIndex, rowIndex: rowIndex, value: splitedTrees)
                                updateTreesForRow(staffIndex: staffIndex, rowIndex: rowIndex, value: splitedTrees)
                            }
                        }
                    }
                    rowIndex += 1
                }
            }
        case .thining:
            if let thining = task?.thining {
                var rowIndex = 0
                thining.rowsInField.forEach { (rowInField) in
                    let staffAsignedRow = thining.staff.filter({ (staff) -> Bool in
                        staff.asignedRows.contains { (asignedRow) -> Bool in
                            asignedRow.asignedRow == rowInField
                        }
                    })
                    if staffAsignedRow.count > 0 {
                        let completed = rowInField.jobsDone.compactMap({$0.completed}).reduce(0, +)
                        
                        let splitedTrees = (rowInField.amountToDo - completed)/staffAsignedRow.count
                        for i in 0..<thining.staff.count {
                            if thining.staff[i].asignedRows.contains(where: { (assignedRow) -> Bool in
                                assignedRow.asignedRow == rowInField
                            }) {
                                let staffIndex = StaffIndex(jobType: .thining, row: i)
                                view?.setTressForRow(staffIndex: staffIndex, rowIndex: rowIndex, value: splitedTrees)
                                updateTreesForRow(staffIndex: staffIndex, rowIndex: rowIndex, value: splitedTrees)
                            }
                        }
                    }
                    rowIndex += 1
                }
            }
        }
    }
    
    func assignRowInField(for staffIndex: StaffIndex, rowIndex: Int) {
        ErrorManager.dropBreadCrumb(breadCrumb: "Assign row in field")

        switch staffIndex.jobType {
        case .pruning:
            if let pruning = task?.pruning {
                let asignedRow = AsignedRowInField(asignedRow: pruning.rowsInField[rowIndex], value: 0)
                task?.pruning?.staff[staffIndex.row].asignedRows.append(asignedRow)
            }
            
        case .thining:
            if let thining = task?.thining {
                let asignedRow = AsignedRowInField(asignedRow: thining.rowsInField[rowIndex], value: 0)
                task?.thining?.staff[staffIndex.row].asignedRows.append(asignedRow)
            }
        }
    }
    
    func removeRowInField(for staffIndex: StaffIndex, rowIndex: Int) {
        ErrorManager.dropBreadCrumb(breadCrumb: "Remove row in field")

        switch staffIndex.jobType {
        case .pruning:
            if let pruning = task?.pruning {
                task?.pruning?.staff[staffIndex.row].asignedRows.removeAll(where: {$0.asignedRow == pruning.rowsInField[rowIndex]})
            }
        case .thining:
            if let thining = task?.thining {
                task?.thining?.staff[staffIndex.row].asignedRows.removeAll(where: {$0.asignedRow == thining.rowsInField[rowIndex]})
            }
        }
    }
    
    func updateTreesForRow(staffIndex: StaffIndex, rowIndex: Int, value: Int) {
        ErrorManager.dropBreadCrumb(breadCrumb: "Update trees for row")

        switch staffIndex.jobType {
        case .pruning:
            if let pruning = task?.pruning {
                let job = pruning.rowsInField[rowIndex]
                let maxValue = job.amountToDo - job.jobsDone.compactMap({$0.completed}).reduce(0, +)
                
                if value > maxValue {
                    view?.showMessage(message: "Trees for this row can not be more than \(maxValue)")
                    view?.setTressForRow(staffIndex: staffIndex, rowIndex: rowIndex, value: 0)
                    return
                }
                guard let index = pruning.staff[staffIndex.row].asignedRows.firstIndex(where: { (item) -> Bool in
                    item.asignedRow == job
                }) else {
                    ErrorManager.trackExeption(name: "invalid Index")
                    return
                }
                
                task?.pruning?.staff[staffIndex.row].asignedRows[index].value = value
            }
        case .thining:
            if let thining = task?.thining {
                let job = thining.rowsInField[rowIndex]
                let maxValue = job.amountToDo - job.jobsDone.compactMap({$0.completed}).reduce(0, +)
                
                if value > maxValue {
                    view?.showMessage(message: "Trees for this row can not be more than \(maxValue)")
                    view?.setTressForRow(staffIndex: staffIndex, rowIndex: rowIndex, value: 0)
                    return
                }
                guard let index = thining.staff[staffIndex.row].asignedRows.firstIndex(where: { (item) -> Bool in
                    item.asignedRow == job
                }) else {
                    ErrorManager.trackExeption(name: "invalid Index")
                    return
                }
                
                task?.thining?.staff[staffIndex.row].asignedRows[index].value = value
            }
        }
    }
    
    func confirmChanges() {
        ErrorManager.dropBreadCrumb(breadCrumb: "Confirm changes")

        guard let task = task else { return }
        interactor.uploadChanges(task: task)
    }
}
