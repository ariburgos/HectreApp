//
//  RatesAndVolumeStaffHeaderView.swift
//  HectreDemoApp
//
//  Created by Viajeros Lado B on 01/08/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import UIKit

protocol RatesAndVolumeStaffHeaderViewProtocol {
    func updateTapMaxTrees(jobType: JobType)
}

@IBDesignable
class RatesAndVolumeStaffHeaderView: UIView {
    @IBOutlet weak var mainLabel: UILabel!
    
    var delegate: RatesAndVolumeStaffHeaderViewProtocol?
    
    var jobType : JobType? {
        didSet {
            switch jobType {
            case .pruning:
                mainLabel.text = "Pruning"
            case .thining:
                mainLabel.text = "Thining"
            case .none:
                break
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
     }

     override init(frame: CGRect) {
         super.init(frame: frame)
     }

    @IBAction func didTapAddMaxTreesButton(_ sender: Any) {
        ErrorManager.dropBreadCrumb(breadCrumb: "Did tap add max trees button")
        guard let jobType = jobType else {
            ErrorManager.trackExeption(name: "Job type is empty")
            return
        }
        delegate?.updateTapMaxTrees(jobType: jobType)
    }
}
