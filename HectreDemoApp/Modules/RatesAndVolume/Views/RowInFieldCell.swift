//
//  RowInFieldCell.swift
//  HectreDemoApp
//
//  Created by Viajeros Lado B on 01/08/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import UIKit

class RowInFieldCell: UICollectionViewCell {
    struct Constants {
        static let cellIdentifier = "RowInFieldCell"
    }
    
    @IBOutlet weak var dotView: RoundedView!
    
    @IBOutlet weak var mainView: RoundedView!
    @IBOutlet weak var mainLabel: UILabel!
    
    var isChecked: Bool = false {
        didSet {
            if isChecked {
                mainView.backgroundColor = .blue
                mainLabel.textColor = .white
            } else {
                mainView.backgroundColor = UIColor.Grey.tone3
                mainLabel.textColor = UIColor.Grey.tone1
            }
        }
    }
}
