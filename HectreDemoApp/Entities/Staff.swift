//
//  Staff.swift
//  HectreDemoApp
//
//  Created by Viajeros Lado B on 04/08/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import Foundation

struct Staff {
    let firstName: String
    let lastName: String
    var rateType: RateType
    var rateHour: Float
    var asignedRows: [AsignedRowInField]
}
