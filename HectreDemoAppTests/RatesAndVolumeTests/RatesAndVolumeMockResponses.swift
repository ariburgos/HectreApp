//
//  RatesAndVolumeMockResponses.swift
//  HectreDemoAppTests
//
//  Created by Viajeros Lado B on 03/08/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import Foundation
@testable import HectreDemoApp

struct RatesAndVolumeMockResponses {
    static let staffOne = Staff(firstName:"Barco", lastName:"Jacobson", rateType: .pieceRate, rateHour: 10, asignedRows: [])
    static let staffTwo = Staff(firstName: "Henry", lastName:"Pham", rateType: .pieceRate, rateHour: 20, asignedRows: [])
    static let staffThree = Staff(firstName: "Darijan", lastName:"Linn", rateType: .pieceRate, rateHour: 30, asignedRows: [])
    
//    static let completedJobOne = RowInFielJobDone(name: "first name", completed: 45)
//    static let completedJobThow = RowInFielJobDone(name: "second name", completed: 22)
//    
    static let jobOne = Job(orchard: "Benji (B1394U)", block: "UB13", rowsInField: [RowsInField(id: 3, jobsDone: [], amountToDo: 500),
    RowsInField(id: 4, jobsDone: [RowInFielJobDone(name: "Yi wan", completed: 250)], amountToDo: 556),
    RowsInField(id: 5, jobsDone: [RowInFielJobDone(name: "Elizabeth Jargrave", completed: 100)], amountToDo: 270)], staff: [staffOne, staffTwo])
    
    static let jobTwo = Job(orchard: "Benji (B1395U)", block: "UB14", rowsInField: [RowsInField(id: 2, jobsDone: [RowInFielJobDone(name: "first name", completed: 45)], amountToDo: 444),
    RowsInField(id: 3, jobsDone: [RowInFielJobDone(name: "second name", completed: 22)], amountToDo: 555)], staff: [staffThree])
    
    static let jobsWithPruningAndThining =  Task(pruning: jobOne, thining: jobTwo)
    static let jobsWithPruning =  Task(pruning: jobOne, thining: nil)
    static let jobsWithThining =  Task(pruning: nil, thining: jobTwo)

}
