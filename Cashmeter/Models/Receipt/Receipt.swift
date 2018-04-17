//
//  Receipt.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 17/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation

struct ReceiptData {
    let fn: String
    let i: String
    let fp: String
    
    init?(fromQrString qrString: String) {
        let dict = qrString.split(separator: "&").reduce(into: [String:String]()) { (result, keyValue) in
            let chunks = keyValue.split(separator: "=")
            guard let first = chunks.first, let last = chunks.last else { return }
            let key = String(first)
            let value = String(last)
            result[key] = value
        }
        
        guard let fn = dict["fn"],
            let i = dict["i"],
            let fp = dict["fp"] else {
                return nil
        }
        
        self.fn = fn
        self.i = i
        self.fp = fp
    }
}
