//
//  SpendingItemTableViewCell.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 23/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

final class SpendingItemTableViewCell: UITableViewCell, HasNib {

    // TODO: Insets
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var priceCountLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var categoryContainer: UIView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    
}
