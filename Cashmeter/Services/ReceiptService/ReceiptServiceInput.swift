//
//  ReceiptServiceInput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 17/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation

protocol ReceiptServiceInput {
    
    func parse(_ receiptData: ReceiptData)
    
}
