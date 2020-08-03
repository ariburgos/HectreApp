//
//  Jobs.swift
//  HectreDemoApp
//
//  Created by Viajeros Lado B on 02/08/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import Foundation

struct Job {
    let orchard: String
    let block: String
    let rowsInField: [RowsInField]
    var staff: [Staff]
}
