//
//  RatesAndVolumeInteractor.swift
//  HectreDemoApp
//
//  Created by Viajeros Lado B on 01/08/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import Foundation

class RatesAndVolumeInteractor: RatesAndVolumeInteractorProtocol {
    weak var presenter: RatesAndVolumePresenterProtocol?
    
    func requestTask(completionHandler: @escaping (Task?) -> ()) {
        ErrorManager.dropBreadCrumb(breadCrumb: "Requesting task")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
            ErrorManager.dropBreadCrumb(breadCrumb: "On response request task")
            let task = self.createMockData()
            completionHandler(task)
        }
    }
    
    func uploadChanges(task: Task) {
        print("pruning staff: \(String(describing: task.pruning?.staff))")
        print("thining staff: \(String(describing: task.thining?.staff))")
    }
    
    private func createMockData() -> Task {
        let staffOne = Staff(firstName: "Barco", lastName: "Jacobson", rateType: .pieceRate, rateHour: 10, asignedRows: [])
        let staffTwo = Staff(firstName: "Henry", lastName: "Pham", rateType: .wages, rateHour: 20, asignedRows: [])
        let staffThree = Staff(firstName: "Darijan", lastName: "Linn", rateType: .pieceRate, rateHour: 30, asignedRows: [])

        let pruningJob = Job(orchard: "Benji (B1394U)", block: "UB13", rowsInField: [RowsInField(id: 3, jobsDone: [], amountToDo: 500),
                                        RowsInField(id: 4, jobsDone: [RowInFielJobDone(name: "Yi wan", completed: 250)], amountToDo: 556),
                                        RowsInField(id: 5, jobsDone: [RowInFielJobDone(name: "Elizabeth Jargrave", completed: 100)], amountToDo: 270)], staff: [staffOne, staffTwo])
        let thiningJob = Job(orchard: "Benji (B1395U)", block: "UB14", rowsInField: [RowsInField(id: 2, jobsDone: [RowInFielJobDone(name: "Steve Jobs", completed: 45)], amountToDo: 444),
                                        RowsInField(id: 3, jobsDone: [RowInFielJobDone(name: "Andy Warhol", completed: 22)], amountToDo: 555)], staff: [staffThree])
        
        let task = Task(pruning: pruningJob, thining: thiningJob)

        return task
    }
}


