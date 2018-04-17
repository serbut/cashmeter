//
//  ReceiptService.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 11/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation

final class ReceiptService: BaseService {
    
}

// MARK: ReceiptServiceInput

extension ReceiptService: ReceiptServiceInput {
    
    func parse(_ receiptData: ReceiptData) {
        
        let params = ["fp": receiptData.fp,
                      "i": receiptData.i,
                      "fn": receiptData.fn]
        
        networkProvider.sendRequest(.parse, parameters: params, completion: {
            
        })
        
    }
    
}
