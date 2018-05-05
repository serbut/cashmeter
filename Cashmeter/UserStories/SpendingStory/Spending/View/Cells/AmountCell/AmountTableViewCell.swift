//
//  AmountTableViewCell.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

protocol AmountTableViewCellDelegate: class {
    
    /**
     Метод сообщает о том, что сумма была изменена.
     */
    func didChangeAmountValue(_ value: String?)
    
}

class AmountTableViewCell: UITableViewCell, HasNib {

    weak var delegate: AmountTableViewCellDelegate!
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var currencyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func didChangeAmount(_ sender: UITextField) {
        delegate.didChangeAmountValue(sender.text)
    }
}

extension AmountTableViewCell: TableCellInput {
    
    func setup(with cellObject: TableCellObject) {
        guard let cellObject = cellObject as? AmountTableViewCellObject else { return }
        
        if let amount = cellObject.amount {
            amountTextField.text = "\(amount)"
        }
        currencyLabel.text = cellObject.currencySign
    }
    
}
