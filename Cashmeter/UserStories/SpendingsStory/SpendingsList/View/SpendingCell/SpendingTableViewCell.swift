//
//  SpendingTableViewCell.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 14/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

final class SpendingTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryIconLabel: UILabel!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

// MARK: TableCellInput

extension SpendingTableViewCell: TableCellInput {
    
    func setup(with cellObject: TableCellObject) {
        guard let cellObject = cellObject as? SpendingTableViewCellObject else { return }
        
        categoryIconLabel.text = ":)"
        categoryNameLabel.text = cellObject.categoryName
        amountLabel.text = "\(cellObject.amount) ₽"
    }
    
}
