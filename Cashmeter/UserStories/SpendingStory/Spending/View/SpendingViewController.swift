//
//  SpendingViewController.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

final class SpendingViewController: UIViewController {
    
    let newSpendingVcTitle = "Добавление покупки"
    let editSpendingVcTitle = "Редактирование покупки"

    var output: SpendingViewOutput!
    var dataDisplayManager: SpendingDataDisplayManagerInput!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var shouldShowDeleteButton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewIsReady()
    }
    
    fileprivate func setupSaveButton() {
        let saveBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "check_bar_button"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(didTapOnSave))
        
        self.navigationItem.rightBarButtonItem = saveBarButton
    }
    
    @objc func didTapOnSave() {
        output.didTapOnSave()
    }
    
    fileprivate func setupCloseAndDeleteButtons() {
        let closeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "close_bar_button"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapOnClose))
        
        if shouldShowDeleteButton {
            let deleteBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "delete_bar_button"),
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(didTapOnDelete))
            
            navigationItem.leftBarButtonItems = [closeBarButton, deleteBarButton]
        } else {
            navigationItem.leftBarButtonItem = closeBarButton
        }
    }
    
    @objc func didTapOnClose() {
        output.didTapOnClose()
    }
    
    @objc func didTapOnDelete() {
        output.didTapOnDelete()
    }

}

// MARK: SpendingViewInput

extension SpendingViewController: SpendingViewInput {
    
    func setupInitialState() {
        navigationController?.title = newSpendingVcTitle
        setupSaveButton()
        setupCloseAndDeleteButtons()
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
    
    func showDeleteButton(_ show: Bool) {
        shouldShowDeleteButton = show
        setupCloseAndDeleteButtons()
    }
    
}

extension SpendingViewController: SpendingDataDisplayManagerOutput {
    
    func didTriggerScanQrAction() {
        output.didTriggerScanQrAction()
    }
    
    func didTriggerShowSpendingItemsAction() {
        output.didTriggerShowSpendingItemsAction()
    }
    
    func didTriggerSelectWalletAction() {
        output.didTriggerSelectWalletAction()
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
