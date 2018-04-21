//
//  AddReceiptTableViewCell.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

class AddReceiptTableViewCell: UITableViewCell, HasNib {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension AddReceiptTableViewCell: TableCellInput {
    
    func setup(with cellObject: TableCellObject) {
        guard let _ = cellObject as? AddReceiptTableViewCellObject else { return }
    }
    
}
