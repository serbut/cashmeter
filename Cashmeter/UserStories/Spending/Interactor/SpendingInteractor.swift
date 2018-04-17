//
//  SpendingInteractor.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

final class SpendingInteractor {
    
    var receiptService: ReceiptService!
    
}

// MARK: SpendingInteractorInput

extension SpendingInteractor: SpendingInteractorInput {
    
    func parseReceipt(_ receipt: ReceiptData) {
        receiptService.parse(receipt)
    }
    
}
