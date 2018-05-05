//
//  SpendingViewController.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

final class SpendingViewController: UIViewController {
    
    let titleVc = "Добавление покупки"
    
    var output: SpendingViewOutput!
    var dataDisplayManager: SpendingDataDisplayManagerInput!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewIsReady()
    }
    
    fileprivate func setupSaveButton() {
        let saveBarButton = UIBarButtonItem(image: UIImage(named: "check_bar_button"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(didTapOnSave))
        
        self.navigationItem.rightBarButtonItem = saveBarButton
    }
    
    @objc func didTapOnSave() {
        output.didTapOnSave()
    }
    
    fileprivate func setupCloseButton() {
        let closeBarButton = UIBarButtonItem(image: UIImage(named: "close_bar_button"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapOnClose))
        
        self.navigationItem.leftBarButtonItem = closeBarButton
    }
    
    @objc func didTapOnClose() {
        output.didTapOnClose()
    }

}

// MARK: SpendingViewInput

extension SpendingViewController: SpendingViewInput {
    
    func setupInitialState() {
        navigationController?.title = titleVc
        setupSaveButton()
        setupCloseButton()
        dataDisplayManager.setup(with: tableView)
    }
    
    func showData(_ cellObjects: [TableCellObject]) {
        dataDisplayManager.showData(cellObjects)
    }
    
    func showLoader() {
        activityIndicatorView.startAnimating()
    }
    
    func hideLoader() {
        activityIndicatorView.stopAnimating()
    }
    
}

extension SpendingViewController: SpendingDataDisplayManagerOutput {
    
    func didTapButton(with type: SpendingButtonType) {
        output.didTapButton(with: type)
    }
    
    func didTriggerScanQrAction() {
        output.didTriggerScanQrAction()
    }
    
    func didTriggerShowSpendingItemsAction() {
        output.didTriggerShowSpendingItemsAction()
    }
    
    func didChangeAmountValue(_ value: String?) {
        output.didChangeAmountValue(value)
    }
    
    func didChangeDateValue(_ value: Date?) {
        output.didChangeDateValue(value)
    }
    
    func didSelectCategory(_ category: Category?) {
        output.didSelectCategory(category)
    }
    
    func didTapAddCategory() {
        output.didTapAddCategory()
    }
    
    func didChangeComment(_ comment: String?) {
        output.didChangeComment(comment)
    }
    
}
