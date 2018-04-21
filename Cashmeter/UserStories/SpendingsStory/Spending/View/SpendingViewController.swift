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
    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.layer.cornerRadius = saveButton.frame.height / 4
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewIsReady()
    }

    @IBAction func didTapSaveButton(_ sender: UIButton) {
    }
    
    fileprivate func setupCloseButton() {
        let closeBarButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                        target: self,
                        action: #selector(didTapOnClose))
        
        self.navigationItem.rightBarButtonItem = closeBarButton
    }
    
    @objc func didTapOnClose() {
        output.didTapOnClose()
    }
}

// MARK: SpendingViewInput

extension SpendingViewController: SpendingViewInput {
    
    func setupInitialState() {
        navigationController?.title = titleVc
        setupCloseButton()
        dataDisplayManager.setup(with: tableView)
    }
    
    func showData(_ cellObjects: [TableCellObject]) {
        dataDisplayManager.showData(cellObjects)
    }
    
}

extension SpendingViewController: SpendingDataDisplayManagerOutput {
    
    func didTapButton(with type: SpendingButtonType) {
        output.didTapButton(with: type)
    }
    
    func didTriggerScanQrAction() {
        output.didTriggerScanQrAction()
    }
    
}
