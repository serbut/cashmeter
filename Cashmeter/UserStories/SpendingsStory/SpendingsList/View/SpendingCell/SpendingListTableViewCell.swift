//
//  SpendingListTableViewCell.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 14/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

final class SpendingListTableViewCell: UITableViewCell, HasNib {

    @IBOutlet weak var categoryIconImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

// MARK: TableCellInput

extension SpendingListTableViewCell: TableCellInput {
    
    func setup(with cellObject: TableCellObject) {
        guard let cellObject = cellObject as? SpendingListTableViewCellObject else { return }
        
        categoryNameLabel.text = cellObject.categoryName
        amountLabel.text = "\(cellObject.amount!) ₽"
        if let imageName = cellObject.categoryImageName {
            categoryIconImageView.image = UIImage(named: imageName)
        }
    }
    
}
