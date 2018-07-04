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
    var spendingItem: SpendingItem?
    
    init(from spendingItem: SpendingItem) {
        self.name = spendingItem.title!
        self.quantity = spendingItem.quantity
        self.price = spendingItem.price
        self.amount = spendingItem.amount
        self.category = spendingItem.category
        self.spendingItem = spendingItem
    }
    
    init(from receiptItemInfo: ReceiptItemInfo) {
        self.name = receiptItemInfo.name
        self.quantity = receiptItemInfo.quantity
        self.price = receiptItemInfo.price
        self.amount = receiptItemInfo.sum
    }
    
}

// MARK: CustomDebugStringConvertible

extension SpendingItemInfo: CustomDebugStringConvertible {
    
    var debugDescription: String {
        return "\(name) — \(price)*\(quantity) = \(amount)\n"
    }
    
}

// MARK: Hashable

extension SpendingItemInfo: Hashable {
    
    var hashValue: Int {
        return name.hashValue + price.hashValue + quantity.hashValue + amount.hashValue
    }
    
    static func == (lhs: SpendingItemInfo, rhs: SpendingItemInfo) -> Bool {
        return lhs.name == rhs.name &&
            lhs.price == rhs.price &&
            lhs.quantity == rhs.quantity &&
            lhs.amount == rhs.amount
    }
    
}
