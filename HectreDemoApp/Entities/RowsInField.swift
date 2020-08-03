//
//  RowsInField.swift
//  HectreDemoApp
//
//  Created by Viajeros Lado B on 04/08/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import Foundation

struct RowsInField {
    let id: Int
    let jobsDone: [RowInFielJobDone]
    let amountToDo: Int
    
    static func == (lhs: RowsInField, rhs: RowsInField) -> Bool {
        // id could be implemented.
        return lhs.id == rhs.id && lhs.amountToDo == rhs.amountToDo
    }
}
