//
//  SpendingListTableViewCell.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 14/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

final class SpendingListTableViewCell: UITableViewCell, HasNib {

    let noCategoryTitle = "Нет категории"
    
    @IBOutlet weak var categoryIconImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    func setup(with spending: Spending) {
        categoryNameLabel.text = spending.category?.title ?? noCategoryTitle
        amountLabel.text = "\(spending.amount) ₽"
        categoryIconImageView.image = UIImage(named: spending.category?.image_name ?? "undefined_category")
    }
    
}

