//
//  RatesAndVolumeViewController.swift
//  HectreDemoApp
//
//  Created by Viajeros Lado B on 01/08/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import UIKit

class RatesAndVolumeViewController: UIViewController {
    var presenter: RatesAndVolumePresenterProtocol?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pruningView: BorderCornerView!
    @IBOutlet weak var thiningView: BorderCornerView!
    @IBOutlet weak var pruningHeaderView: UIView!
    @IBOutlet weak var thiningHeaderView: UIView!
    
    @IBOutlet weak var pruningStackView: UIStackView!
    @IBOutlet weak var thiningStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "update rate & volume"
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        presenter?.loadView()
    }
    
    @IBAction func didTapConfirmButton(_ sender: Any) {
        ErrorManager.dropBreadCrumb(breadCrumb: "Did tap confirm button")
        presenter?.confirmChanges()
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
    }
}

// MARK:- RatesAndVolumeViewProtocol
extension RatesAndVolumeViewController: RatesAndVolumeViewProtocol {
    
    func setRateType(for staffIndex: StaffIndex, rateType: RateType) {
        ErrorManager.dropBreadCrumb(breadCrumb: "Set rate type")
        
        switch staffIndex.jobType {
        case .pruning:
            pruningStackView.subviews.forEach({
                if $0.tag == staffIndex.row,
                    let staffView = $0 as? RatesAndVolumeStaffView {
                    staffView.setRateType(rateType: rateType)
                    
                }})
        case .thining:
            thiningStackView.subviews.forEach({
                if $0.tag == staffIndex.row,
                    let staffView = $0 as? RatesAndVolumeStaffView {
                    staffView.setRateType(rateType: rateType)
                }})
        }
    }
    
    func addStaffView(staffIndex: StaffIndex, staffViewModel: StaffViewModel) {
        ErrorManager.dropBreadCrumb(breadCrumb: "Add staff view")

        let view = RatesAndVolumeStaffView.fromNib()
        view.staffIndex = staffIndex
        view.tag = staffIndex.row
        view.delegate = self
        view.viewModel = staffViewModel
        switch staffIndex.jobType {
        case .pruning:
            if pruningStackView.subviews.count <= 1 {
                let headerView = RatesAndVolumeStaffHeaderView.fromNib()
                headerView.frame = pruningHeaderView.bounds
                headerView.jobType = .pruning
                headerView.delegate = self
                view.removeSeparatorView()
                pruningHeaderView.addSubview(headerView)
            }
            pruningStackView.addArrangedSubview(view)
        case .thining:
            if thiningStackView.subviews.count <= 1 {
                let headerView = RatesAndVolumeStaffHeaderView.fromNib()
                headerView.frame = thiningHeaderView.bounds
                headerView.jobType = .thining
                headerView.delegate = self
                view.removeSeparatorView()
                thiningHeaderView.addSubview(headerView)
            }
            thiningStackView.addArrangedSubview(view)
        }
    }
    
    func setTressForRow(staffIndex: StaffIndex, rowIndex: Int, value: Int) {
        ErrorManager.dropBreadCrumb(breadCrumb: "Set trees for row")

        switch staffIndex.jobType {
        case .pruning:
            pruningStackView.subviews.forEach({
                if $0.tag == staffIndex.row,
                    let staffView = $0 as? RatesAndVolumeStaffView {
                    staffView.setTressForRow(rowIndex: rowIndex, value: value)
                    
                }})
        case .thining:
            thiningStackView.subviews.forEach({
                if $0.tag == staffIndex.row,
                    let staffView = $0 as? RatesAndVolumeStaffView {
                    staffView.setTressForRow(rowIndex: rowIndex, value: value)
                }})
        }
    }
    
    func setRateHour(staffIndex: StaffIndex, rate: Float) {
        ErrorManager.dropBreadCrumb(breadCrumb: "Set rate hour")

        switch staffIndex.jobType {
        case .pruning:
            pruningStackView.subviews.forEach({
                if $0.tag == staffIndex.row,
                    let staffView = $0 as? RatesAndVolumeStaffView {
                    staffView.setRateHour(rate: rate)
                    
                }})
        case .thining:
            thiningStackView.subviews.forEach({
                if $0.tag == staffIndex.row,
                    let staffView = $0 as? RatesAndVolumeStaffView {
                    staffView.setRateHour(rate: rate)
                }})
        }
    }
    
    
    func setRateHourForAll(jobType: JobType, rate: Float) {
        ErrorManager.dropBreadCrumb(breadCrumb: "Set rate hour for all")

        switch jobType {
        case .pruning:
            pruningStackView.subviews.forEach { (view) in
                guard let staffView = view as? RatesAndVolumeStaffView else { return }
                staffView.setRateHour(rate: rate)
            }
        case .thining:
            thiningStackView.subviews.forEach { (view) in
                guard let staffView = view as? RatesAndVolumeStaffView else { return }
                staffView.setRateHour(rate: rate)
            }
        }
    }
    
    func hidePruningView() {
        ErrorManager.dropBreadCrumb(breadCrumb: "Hide pruning view")
        pruningView.isHidden = true
     }
     
     func hideThiningView() {
        ErrorManager.dropBreadCrumb(breadCrumb: "Hide thining view")
        thiningView.isHidden = true
     }
    
    // Note to reviewer: This methods can be added to the BaseViewController.
    func showMessage(message: String) {
        ErrorManager.dropBreadCrumb(breadCrumb: "Show message view")

        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func showLoading() {
        ErrorManager.dropBreadCrumb(breadCrumb: "Show loading view")

        LoadingView.shared.showIndicator()
    }
    
    func hideLoading() {
        ErrorManager.dropBreadCrumb(breadCrumb: "Hide loading view")

        LoadingView.shared.hideIndicator()
    }
    
}

// MARK:- RatesAndVolumeStaffViewProtocol
extension RatesAndVolumeViewController: RatesAndVolumeStaffViewProtocol {
    func assignRowInField(for staffIndex: StaffIndex, rowIndex: Int) {
        presenter?.assignRowInField(for: staffIndex, rowIndex: rowIndex)
    }
    
    func removeRowInField(for staffIndex: StaffIndex, rowIndex: Int) {
        presenter?.removeRowInField(for: staffIndex, rowIndex: rowIndex)
    }
    
    func rowInField(for staffIndex: StaffIndex, rowIndex: Int) -> TreesForRowViewModel? {
        return presenter?.rowInField(for: staffIndex, rowIndex: rowIndex)
    }
    
    func updateRateType(for staffIndex: StaffIndex, rateType: RateType) {
        presenter?.updateRateType(for: staffIndex, rateType: rateType)
    }
    
    func updateRateHour(for staffIndex: StaffIndex, rate: Float) {
        presenter?.updateRateHour(for: staffIndex, rate: rate)
    }
    
    func updateRateHourForAll(for staffIndex: StaffIndex, rate: Float) {
        presenter?.updateRateHourForAll(for: staffIndex, rate: rate)
    }
    
    func countOfRowsInField(for staffIndex: StaffIndex) -> Int {
        return presenter?.countOfRowsInField(for: staffIndex) ?? 0
    }
    
    func updateTreesForRow(staffIndex: StaffIndex, rowIndex: Int, value: Int) {
        presenter?.updateTreesForRow(staffIndex: staffIndex, rowIndex: rowIndex, value: value)
    }
}

// MARK:- RatesAndVolumeStaffHeaderViewProtocol
extension RatesAndVolumeViewController: RatesAndVolumeStaffHeaderViewProtocol {
    func updateTapMaxTrees(jobType: JobType) {
        presenter?.updateTapMaxTrees(jobType: jobType)
    }
}
