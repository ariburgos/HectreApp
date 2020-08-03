//
//  RatesAndVolumeStaffView.swift
//  HectreDemoApp
//
//  Created by Viajeros Lado B on 01/08/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import UIKit


protocol RatesAndVolumeStaffViewProtocol {
    func updateRateType(for staffIndex: StaffIndex, rateType: RateType)
    func updateRateHour(for staffIndex: StaffIndex, rate: Float)
    func updateRateHourForAll(for staffIndex: StaffIndex, rate: Float)
    func countOfRowsInField(for staffIndex: StaffIndex) -> Int
    func rowInField(for staffIndex: StaffIndex, rowIndex: Int) -> TreesForRowViewModel?
    func assignRowInField(for staffIndex: StaffIndex, rowIndex: Int)
    func removeRowInField(for staffIndex: StaffIndex, rowIndex: Int)
    func updateTreesForRow(staffIndex: StaffIndex, rowIndex: Int, value: Int)
}

class RatesAndVolumeStaffView: UIView {
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var initialsView: RoundedView!
    @IBOutlet weak var initialsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var orchardLabel: UILabel!
    @IBOutlet weak var blockLabel: UILabel!
    @IBOutlet weak var wagesButton: CornerButton!
    @IBOutlet weak var pieceRateButton: CornerButton!
    @IBOutlet weak var wagesDescriptionLabel: UILabel!
    @IBOutlet weak var pieceRateView: UIView!
    @IBOutlet weak var rateTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var treesForRowStackView: UIStackView!
    
    
    var delegate: RatesAndVolumeStaffViewProtocol?
    var staffIndex: StaffIndex?
    var viewModel: StaffViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            nameLabel.text = "\(viewModel.name.firstName) \(viewModel.name.lastName)"
            orchardLabel.text = viewModel.orchard
            blockLabel.text = viewModel.block
            if let firstInitial = viewModel.name.firstName.first,
                let secondInitial = viewModel.name.lastName.first{
                initialsLabel.text = String(firstInitial) + String(secondInitial)
            }
            initialsView.backgroundColor = UIColor.random()
        }
    }
    
    override func didMoveToSuperview() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "RowInFieldCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "RowInFieldCell")
        rateTextField.delegate = self
    }
    
    @IBAction func didTapPieceRateButton(_ sender: Any) {
        selectPieceRate()
    }
    
    @IBAction func didTapWagesButton(_ sender: Any) {
        selectWages()
    }
    
    @IBAction func didTapApplyToAllButton(_ sender: Any) {
        guard let rateText = rateTextField.text,
            let rate = Float(rateText),
            let staffIndex = staffIndex else { return }
        
        delegate?.updateRateHourForAll(for: staffIndex, rate: rate)
    }
    
    @IBAction func didSetTextFieldValue(_ sender: Any) {
        guard let rateText = rateTextField.text,
            let rate = Float(rateText),
            let staffIndex = staffIndex else { return }
        delegate?.updateRateHour(for: staffIndex, rate: rate)
    }
    
    func setRateHour(rate: Float) {
        rateTextField.text = String(rate)
    }
    
    func setTressForRow(rowIndex: Int, value: Int) {
        treesForRowStackView.subviews.forEach { (view) in
            if let treesForRowView = view as? TreesForRowView,
                treesForRowView.tag == rowIndex {
                treesForRowView.textfield.text = String(value)
            }
        }
    }
    
    func setRateType(rateType: RateType) {
        switch rateType {
        case .pieceRate:
            selectPieceRate()
        case .wages:
            selectWages()
        }
    }
    
    func removeSeparatorView() {
        separatorView.isHidden = true
    }

    
    private func selectPieceRate() {
        ErrorManager.dropBreadCrumb(breadCrumb: "Did select piece rate button")
        
        wagesDescriptionLabel.isHidden = true
        pieceRateView.isHidden = false
        
        pieceRateButton.backgroundColor = UIColor.AppColors.main
        pieceRateButton.setTitleColor(UIColor.white, for: .normal)
        
        wagesButton.backgroundColor = UIColor.Grey.tone3
        wagesButton.setTitleColor(UIColor.Grey.tone1, for: .normal)
    }
    
    private func selectWages() {
        ErrorManager.dropBreadCrumb(breadCrumb: "Did select wages button")

        pieceRateView.isHidden = true
        wagesDescriptionLabel.isHidden = false
        
        wagesButton.backgroundColor = UIColor.AppColors.main
        wagesButton.setTitleColor(UIColor.white, for: .normal)
        
        pieceRateButton.backgroundColor = UIColor.Grey.tone3
        pieceRateButton.setTitleColor(UIColor.Grey.tone1, for: .normal)
    }
}

extension RatesAndVolumeStaffView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let staffIndex = self.staffIndex else {
            ErrorManager.trackExeption(name: "Staff index is nil")
            return 0
        }
        return delegate?.countOfRowsInField(for: staffIndex) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RowInFieldCell.Constants.cellIdentifier, for: indexPath) as! RowInFieldCell
        
        if let staffIndex = self.staffIndex {
            if let viewModel = delegate?.rowInField(for: staffIndex, rowIndex: indexPath.row) {
                cell.mainLabel.text = String(viewModel.id)
                cell.dotView.isHidden = viewModel.completedJobs.isEmpty
                if viewModel.isSelected {
                    addTreeForRowView(rowIndex: indexPath.row)
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ErrorManager.dropBreadCrumb(breadCrumb: "Did select row in field cell")

        if let cell = collectionView.cellForItem(at: indexPath) as? RowInFieldCell {
            guard let staffIndex = self.staffIndex else {
                ErrorManager.trackExeption(name: "Staff index is nil")
                return
            }
            let indexRow = indexPath.row
            
            if cell.isChecked {
                delegate?.removeRowInField(for: staffIndex, rowIndex: indexRow)
                
            } else {
                delegate?.assignRowInField(for: staffIndex, rowIndex: indexRow)
            }
            
            cell.isChecked = !cell.isChecked
            
            if cell.isChecked {
                addTreeForRowView(rowIndex: indexRow)
            } else {
                treesForRowStackView.subviews.forEach({
                    if $0.tag == indexPath.row {
                        $0.removeFromSuperview()
                    }})
            }
        }
    }

    private func addTreeForRowView(rowIndex: Int) {
        guard let staffIndex = self.staffIndex else { return }
        
        let view =  TreesForRowView.fromNib()
        if let viewModel = delegate?.rowInField(for: staffIndex, rowIndex: rowIndex) {
            view.viewModel = viewModel
            view.tag = rowIndex
            view.delegate = self
        }
        addOrderedView(view: view)
    }
    
    private func addOrderedView(view: TreesForRowView) {
        let viewsBelow = treesForRowStackView.subviews.filter({$0.tag < view.tag}).count
        treesForRowStackView.insertArrangedSubview(view, at: viewsBelow)
    }
}

extension RatesAndVolumeStaffView: TreesForRowViewProtocol {
    func updateTreesForRow(rowIndex: Int, value: Int) {
        guard let staffIndex = staffIndex else { return }
        delegate?.updateTreesForRow(staffIndex: staffIndex, rowIndex: rowIndex, value: value)
    }
}

// MARK:- UITextFieldDelegate
extension RatesAndVolumeStaffView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
    }
}
