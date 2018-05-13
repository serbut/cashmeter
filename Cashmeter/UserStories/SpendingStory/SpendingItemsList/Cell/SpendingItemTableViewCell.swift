//
//  SpendingItemTableViewCell.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 23/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

final class SpendingItemTableViewCell: UITableViewCell, HasNib {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceCountLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
