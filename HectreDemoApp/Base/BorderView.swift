//
//  BorderView.swift
//  HectreDemoApp
//
//  Created by Viajeros Lado B on 01/08/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import UIKit

@IBDesignable
class BorderCornerView: UIView {
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.borderWidth = 1
            layer.cornerRadius = cornerRadius
        }
    }
}
