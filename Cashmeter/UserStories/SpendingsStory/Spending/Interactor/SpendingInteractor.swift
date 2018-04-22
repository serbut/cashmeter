//
//  SpendingInteractor.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

final class SpendingInteractor {
    
    var receiptService: ReceiptServiceInput!
    var spendingService: SpendingServiceInput!
    var categoryService: CategoryService!
    
}

// MARK: SpendingInteractorInput

extension SpendingInteractor: SpendingInteractorInput {
    
    func parseReceipt(_ receipt: ReceiptData) {
        receiptService.parse(receipt)
    }
    
    func requestCategories() -> [Category] {
        return categoryService.getCategories()
    }
    
    func addSpending(spendingInfo: SpendingInfo) {
        spendingService.addSpending(withInfo: spendingInfo)
    }
    
}
