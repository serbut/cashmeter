//
//  ReceiptItemInfo.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 22/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

struct ReceiptItemInfo: Codable {
    
    var name: String
    var quantity: Double
    var price: Double
    var sum: Double
    
}

extension ReceiptItemInfo: CustomDebugStringConvertible {
    
    var debugDescription: String {
        return "\(name) — \(price)*\(quantity) = \(sum)\n"
    }
    
}
