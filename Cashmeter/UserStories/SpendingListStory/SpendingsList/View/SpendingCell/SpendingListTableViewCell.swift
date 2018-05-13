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
    @IBOutlet weak var dateLabel: UILabel!
    
    func setup(with spending: Spending) {
        categoryNameLabel.text = spending.category?.title ?? noCategoryTitle
        let currencySign = spending.wallet?.currency?.label ?? "₽"
        amountLabel.text = "\(spending.amount) \(currencySign)"
        categoryIconImageView.image = UIImage(named: spending.category?.image_name ?? "undefined_category")
        dateLabel.text = spending.date!.shortFormat
    }
    
}

