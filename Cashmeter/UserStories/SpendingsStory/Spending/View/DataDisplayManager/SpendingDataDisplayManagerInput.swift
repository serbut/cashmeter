//
//  SpendingDataDisplayManagerInput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

protocol SpendingDataDisplayManagerInput: class {
    
    func setup(with tableView: UITableView)
    func showData(_ cellObjects: [TableCellObject])
    
}
