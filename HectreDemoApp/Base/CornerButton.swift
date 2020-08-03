//
//  CornerButton.swift
//  HectreDemoApp
//
//  Created by Viajeros Lado B on 01/08/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import UIKit

@IBDesignable
class CornerButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.borderWidth = 1
            layer.borderColor = UIColor.clear.cgColor
            layer.cornerRadius = cornerRadius

        }
    }
}
