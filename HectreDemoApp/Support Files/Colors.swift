//
//  Colors.swift
//  HectreDemoApp
//
//  Created by Viajeros Lado B on 01/08/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import UIKit

extension UIColor {
    
    struct AppColors {
        static let main = UIColor(named: "MainColor")
        static let secondary = UIColor(named: "SecondaryColor")
    }
    
    struct Grey {
        static let tone1 = UIColor(named: "GreyTone1")
        static let tone2 = UIColor(named: "GreyTone2")
        static let tone3 = UIColor(named: "GreyTone3")
        static let tone4 = UIColor(named: "GreyTone4")
    }
    
    static func random() -> UIColor {
        return UIColor (
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
