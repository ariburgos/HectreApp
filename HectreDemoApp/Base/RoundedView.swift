//
//  RoundedView.swift
//  HectreDemoApp
//
//  Created by Viajeros Lado B on 01/08/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
           didSet {
               setNeedsLayout()
           }
       }
    
        override func layoutSubviews() {
            super.layoutSubviews()

            layer.borderWidth = 1
            layer.cornerRadius = cornerRadius
            layer.borderColor = UIColor.clear.cgColor
    }
    
}
