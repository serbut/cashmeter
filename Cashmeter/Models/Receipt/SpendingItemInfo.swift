//
//  SpendingItemInfo.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 22/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

struct SpendingItemInfo: Codable {
    
    var name: String
    var quantity: Double
    var price: Double
    var sum: Double
    
    init(from spendingItem: SpendingItem) {
        self.name = spendingItem.title!
        self.quantity = spendingItem.quantity
        self.price = spendingItem.price
        self.sum = spendingItem.sum
    }
    
}

extension SpendingItemInfo: CustomDebugStringConvertible {
    
    var debugDescription: String {
        return "\(name) — \(price)*\(quantity) = \(sum)\n"
    }
    
}
