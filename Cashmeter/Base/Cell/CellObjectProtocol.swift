//
//  CellObjectProtocol.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

protocol TableCellObject {
    
    var cellClass: UITableViewCell.Type! { get set }
    
}
