//
//  AmountTableViewCellObject.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

struct AmountTableViewCellObject: TableCellObject {
    
    var cellClass: UITableViewCell.Type!
    
    var amount: Double!
    var currencySign: String!
    
}
