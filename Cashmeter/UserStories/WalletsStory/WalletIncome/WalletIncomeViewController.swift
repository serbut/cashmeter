//
//  WalletIncomeViewController.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 12/05/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

class WalletIncomeViewController: UIViewController {
    
    let vcTitle = "Поступление средств"
    let fillAmountError = "Введите сумму поступления"
    var wallet: Wallet!
    var walletService: WalletService!
    
    @IBOutlet weak var amountTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = vcTitle
        setupSaveButton()
        setupCloseButton()
    }
    
    fileprivate func setupSaveButton() {
        let saveBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "check_bar_button"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(didTapOnSave))
        
        navigationItem.rightBarButtonItem = saveBarButton
    }
    
    @objc func didTapOnSave() {
        guard let amountText = amountTextField.text,
            let amount = Double(amountText) else {
                showAlert(with: fillAmountError)
                return
        }
        
        // TODO: Let enter two digits after comma at max
        
        walletService.updateBalance(wallet, amount: amount, isIncome: true)
        // TODO: Show loader, move to completion
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupCloseButton() {
        let closeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "close_bar_button"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapOnClose))
        
        navigationItem.leftBarButtonItem = closeBarButton
    }
    
    @objc func didTapOnClose() {
        dismiss(animated: true, completion: nil)
    }
    
    func showAlert(with message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: SpendingConstants.closeActionTitle, style: .cancel, handler: nil)
        alert.addAction(closeAction)
        present(alert, animated: true, completion: nil)
    }
    
}
