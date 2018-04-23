//
//  SpendingInfo.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 22/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation

final class SpendingInfo {
    
    var spending: Spending?
    
    var amount: Double
    var currency: Currency?
    var category: Category?
    var date: Date
    var receiptItems: [SpendingItemInfo]?
    var comment: String
    
    init() {
        self.amount = 0
        self.comment = ""
        self.date = Date()
    }
    
    init(from spending: Spending) {
        self.spending = spending
        self.amount = spending.amount
        self.currency = spending.currency
        self.category = spending.category
        self.date = spending.date!
        self.receiptItems = spending.items?.allObjects.map { SpendingItemInfo(from: $0 as! SpendingItem) }
        self.comment = spending.comment ?? ""
    }
        
}
