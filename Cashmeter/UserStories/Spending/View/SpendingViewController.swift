//
//  SpendingViewController.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

final class SpendingViewController: UIViewController {
    
    var output: SpendingViewOutput!
    var dataDisplayManager: SpendingDataDisplayManagerInput!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewIsReady()
    }

}

// MARK: SpendingViewInput

extension SpendingViewController: SpendingViewInput {
    
    func setupInitialState() {
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
