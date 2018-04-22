//
//  SpendingServiceInput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 22/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation

protocol SpendingServiceInput {
    
    func addSpending(withInfo spendingInfo: SpendingInfo)
    
}
