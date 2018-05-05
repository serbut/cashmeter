//
//  SelectWalletViewController.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 05/05/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

class SelectWalletViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var walletService: WalletService = ServicesAssembly().walletService() 
    var wallets: [Wallet]!

    override func viewDidLoad() {
        super.viewDidLoad()

        wallets = walletService.getWallets()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupAddWalletButton()
    }
    
    // TODO: Setup with input

    private func setupAddWalletButton() {
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add,
                                           target: self,
                                           action: #selector(didTapOnAdd))
        
        self.navigationItem.rightBarButtonItem = addBarButton
    }
    
    @objc func didTapOnAdd() {
        let newWalletVC = EditWalletViewController()
        
        let servicesAssembly = ServicesAssembly()
        newWalletVC.walletService = servicesAssembly.walletService()
        newWalletVC.currencyService = servicesAssembly.currencyService()
        
        self.present(UINavigationController(rootViewController: newWalletVC), animated: true)
    }

}

// MARK: UITableViewDataSource

extension SelectWalletViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wallets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: SelectWalletTableViewCell.self, at: indexPath) as! SelectWalletTableViewCell
        
        let walletForCell = wallets[indexPath.row]
        cell.nameLabel.text = walletForCell.name
        cell.balanceLabel.text = "\(walletForCell.balance)"
        cell.currencySignLabel.text = walletForCell.currency?.label
        
        return cell
    }
    
}

extension SelectWalletViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Tell output, that wallet was selected
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
}
