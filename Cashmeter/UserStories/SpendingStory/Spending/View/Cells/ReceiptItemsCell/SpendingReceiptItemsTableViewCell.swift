//
//  SpendingReceiptItemsTableViewCell.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 22/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

class SpendingReceiptItemsTableViewCell: UITableViewCell, HasNib {

    @IBOutlet weak var receiptItemsInfoLabel: UILabel!
   
}

extension SpendingReceiptItemsTableViewCell: TableCellInput {
    
    func setup(with cellObject: TableCellObject) {
        guard let cellObject = cellObject as? SpendingReceiptItemsTableViewCellObject else { return }
        
        receiptItemsInfoLabel.text = cellObject.receiptItemsDetailsText
    }
    
}
