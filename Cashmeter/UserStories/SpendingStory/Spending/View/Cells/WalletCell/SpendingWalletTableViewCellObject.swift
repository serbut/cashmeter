//
//  SpendingWalletTableViewCellObject.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 05/05/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

struct SpendingWalletTableViewCellObject: TableCellObject {
    
    var cellClass: UITableViewCell.Type!
    
    var walletName: String!
    var walletBalance: Double!
    var walletCurrencySign: String!
    
}
