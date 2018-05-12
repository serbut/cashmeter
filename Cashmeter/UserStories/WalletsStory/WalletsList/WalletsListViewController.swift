//
//  WalletsListViewController.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 04/05/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

final class WalletsListViewController: UIViewController {

    let vcTitle = "Кошельки"
    
    @IBOutlet weak var tableView: UITableView!
    var walletService: WalletService! {
        didSet {
            wallets = walletService.getWallets()
        }
    }
    var wallets: [Wallet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = vcTitle
        tableView.dataSource = self
        tableView.delegate = self
        
        setupAddWalletButton()
    }
    
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

extension WalletsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wallets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: WalletsListTableViewCell.self, at: indexPath) as! WalletsListTableViewCell
        
        let walletForCell = wallets[indexPath.row]
        
        cell.nameLabel.text = walletForCell.name
        cell.amountLabel.text = "\(walletForCell.balance) \(walletForCell.currency?.label ?? "")"
        return cell
    }
    
}

extension WalletsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let wallet = wallets[indexPath.row]
        
        let viewController = WalletIncomeViewController()
        viewController.walletService = ServicesAssembly().walletService()
        viewController.wallet = wallet
        let navVC = UINavigationController(rootViewController: viewController)
        
        present(navVC, animated: true, completion: nil)
    }
    
}
