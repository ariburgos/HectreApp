//
//  TreesForRowView.swift
//  HectreDemoApp
//
//  Created by Viajeros Lado B on 01/08/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import UIKit

typealias TreesForRowViewModel = (id: Int, completed: Int, maxValue: Int, completedJobs: [String], isSelected: Bool)

protocol TreesForRowViewProtocol {
    func updateTreesForRow(rowIndex: Int, value: Int)
}

class TreesForRowView: UIView {
    struct Constants {
        static let fontSize: CGFloat = 7
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var maxValueLabel: UILabel!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    
    var delegate: TreesForRowViewProtocol?
    var viewModel: TreesForRowViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            titleLabel.text = "Trees for row \(String(viewModel.id))"
            maxValueLabel.text = String(viewModel.maxValue)
            textfield.text = String(viewModel.completed)
            
            for i in 0..<viewModel.completedJobs.count {
                let label = UILabel()
                label.font = UIFont.systemFont(ofSize: Constants.fontSize, weight: .light)
                label.text = viewModel.completedJobs[i]
                stackView.addArrangedSubview(label)
            }
        }
    }
    
    @IBAction func didSetTextFieldValue(_ sender: Any) {
        ErrorManager.dropBreadCrumb(breadCrumb: "did set textfield")
        guard let valueText = textfield.text,
            let value = Int(valueText) else {
                ErrorManager.trackExeption(name: "Value of text is invalid")
                return
        }
        delegate?.updateTreesForRow(rowIndex: tag, value: value)
    }
    
    override func didMoveToSuperview() {
        textfield.delegate = self
    }

}

// MARK:- UITextFieldDelegate
extension TreesForRowView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument) 
    }
}
