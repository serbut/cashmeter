//
//  WalletsListTableViewCell.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 04/05/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

final class WalletsListTableViewCell: UITableViewCell, HasNib {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
