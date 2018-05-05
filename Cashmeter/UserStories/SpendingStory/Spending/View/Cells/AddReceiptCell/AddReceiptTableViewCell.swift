//
//  AddReceiptTableViewCell.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

class AddReceiptTableViewCell: UITableViewCell, HasNib, TableCellInput {

    func setup(with cellObject: TableCellObject) {
        guard let _ = cellObject as? AddReceiptTableViewCellObject else { return }
    }
    
}
