//
//  ReceiptInfo.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 22/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

struct ReceiptInfo: Codable {
    
    var sum: Double
    var items: [SpendingItemInfo]
    
}
