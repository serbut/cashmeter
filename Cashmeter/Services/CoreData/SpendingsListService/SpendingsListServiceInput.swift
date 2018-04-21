//
//  SpendingsListServiceInput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 21/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation

protocol SpendingsListServiceInput: class {
    
    func spendingsSectionsCount() -> Int
    
    func spendingsCount(in section: Int) -> Int
    
    func spendingAtIndexPath(_ indexPath: IndexPath) -> Spending

}
