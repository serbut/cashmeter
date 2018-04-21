//
//  AmountTableViewCell.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

class AmountTableViewCell: UITableViewCell, HasNib {

    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var currencyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

extension AmountTableViewCell: TableCellInput {
    
    func setup(with cellObject: TableCellObject) {
        guard let cellObject = cellObject as? AmountTableViewCellObject else { return }
        
        if let amount = cellObject.amount {
            amountTextField.text = "\(amount)"
        }
    }
    
}
