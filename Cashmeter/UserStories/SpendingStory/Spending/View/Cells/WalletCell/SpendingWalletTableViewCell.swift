//
//  SpendingWalletTableViewCell.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 05/05/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

class SpendingWalletTableViewCell: UITableViewCell, HasNib {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var currencySignLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// MARK: TableCellInput

extension SpendingWalletTableViewCell: TableCellInput {
    
    func setup(with cellObject: TableCellObject) {
        guard let cellObject = cellObject as? SpendingWalletTableViewCellObject else { return }
        
        nameLabel.text = cellObject.walletName
        balanceLabel.text = "\(cellObject.walletBalance)"
        currencySignLabel.text = cellObject.walletCurrencySign
    }
    
}

