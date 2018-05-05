//
//  SpendingsListSpendingsListDisplayManagerOutput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 21/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation

protocol SpendingsListDisplayManagerOutput: class {
    
    /**
     Метод сообщает о том, что была нажата ячейка.
     */
    func didSelectSpending(spending: Spending)
    
}
