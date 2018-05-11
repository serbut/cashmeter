//
//  SpendingWalletTableViewCell.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 05/05/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

class SpendingWalletTableViewCell: UITableViewCell, HasNib {

    let noWalletTitle = "Кошелек не выбран"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var currencySignLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

// MARK: TableCellInput

extension SpendingWalletTableViewCell: TableCellInput {
    
    func setup(with cellObject: TableCellObject) {
        guard let cellObject = cellObject as? SpendingWalletTableViewCellObject else { return }
        
        nameLabel.text = cellObject.walletName ?? noWalletTitle
        balanceLabel.text = "\(cellObject.walletBalance)"
        currencySignLabel.text = cellObject.walletCurrencySign ?? ""
    }
    
}

