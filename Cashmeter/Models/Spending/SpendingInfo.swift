//
//  SpendingInfo.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 22/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation

final class SpendingInfo {
    
    var amount: Double
    var currency: Currency?
    var category: Category?
    var date: Date
    var details: String
    
    init() {
        self.amount = 0
        self.details = ""
        self.date = Date()
    }
    
    init(from spending: Spending) {
        self.amount = spending.amount
        self.currency = spending.currency
        self.category = spending.category
        self.date = spending.date!
        self.details = spending.details ?? ""
    }
        
}