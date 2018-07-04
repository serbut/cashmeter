//
//  CategoriesTableViewCellObject.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 21/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

struct CategoriesTableViewCellObject: TableCellObject {
    
    var cellClass: UITableViewCell.Type!
    
    var categories: [Category]!
    var selectedCategory: Category?
    
}
