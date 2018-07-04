//
//  EditWalletViewController.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 04/05/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

final class EditWalletViewController: UIViewController {
    
    let vcTitle = "Новый кошелек"
    let fillTitleError = "Введите название"
    let fillBalanceError = "Введите текущий баланс"
    let chooseCurrencyError = "Выберите валюту"
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var currentBalanceTextField: UITextField!
    @IBOutlet weak var currenciesTableView: UITableView!
    
    var walletService: WalletService!
    var currencyService: CurrencyService! {
        didSet {
            currencies = currencyService.getCurrencies()
        }
    }

    var currencies: [Currency] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = vcTitle
        hideKeyboardWhenTappedAround()
        
        currenciesTableView.dataSource = self
        currenciesTableView.delegate = self
        setupSaveButton()
        setupCloseButton()
    }
    
    fileprivate func setupSaveButton() {
        let saveBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "check_bar_button"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(didTapOnSave))
        
        self.navigationItem.rightBarButtonItem = saveBarButton
    }
    
    @objc func didTapOnSave() {
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(with: fillTitleError)
            return
        }
        guard let balanceText = currentBalanceTextField.text,
            let balance = Double(balanceText) else {
            showAlert(with: fillBalanceError)
            return
        }
        guard let selectedCurrencyIndex = currenciesTableView.indexPathForSelectedRow?.row else {
            showAlert(with: chooseCurrencyError)
            return
        }
        
        // TODO: Let enter two digits after comma at max
        
        let currency = currencies[selectedCurrencyIndex]
        walletService.addWallet(withName: name, currency: currency, balance: balance)
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupCloseButton() {
        let closeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "close_bar_button"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapOnClose))
        
        self.navigationItem.leftBarButtonItem = closeBarButton
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

// MARK: UITableViewDataSource

extension EditWalletViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: CurrencyListTableViewCell.self, at: indexPath) as! CurrencyListTableViewCell
        
        let currencyForCell = currencies[indexPath.row]
        cell.nameLabel.text = currencyForCell.name
        cell.signLabel.text = currencyForCell.label
        
        return cell
    }
    
}

// MARK: UITableViewDelegate

extension EditWalletViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
}
