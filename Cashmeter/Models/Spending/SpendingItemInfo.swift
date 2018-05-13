//
//  SpendingItemInfo.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 13/05/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation

final class SpendingItemInfo {

    var name: String
    var quantity: Double
    var price: Double
    var amount: Double
    var category: Category?
    
    init(from spendingItem: SpendingItem) {
        self.name = spendingItem.title!
        self.quantity = spendingItem.quantity
        self.price = spendingItem.price
        self.amount = spendingItem.amount
    }
    
    init(from receiptItemInfo: ReceiptItemInfo) {
        self.name = receiptItemInfo.name
        self.quantity = receiptItemInfo.quantity
        self.price = receiptItemInfo.price
        self.amount = receiptItemInfo.sum
    }
    
}

extension SpendingItemInfo: CustomDebugStringConvertible {
    
    var debugDescription: String {
        return "\(name) — \(price)*\(quantity) = \(amount)\n"
    }
    
}
