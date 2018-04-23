//
//  SpendingInteractor.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

final class SpendingInteractor {
    
    weak var output: SpendingInteractorOutput!
    
    var receiptService: ReceiptServiceInput!
    var spendingService: SpendingServiceInput!
    var categoryService: CategoryService!
    
}

// MARK: SpendingInteractorInput

extension SpendingInteractor: SpendingInteractorInput {
    
    func parseReceipt(_ receipt: ReceiptData) {
        receiptService.parse(receipt) { [weak self] (response: ServiceResponse<ReceiptInfo>) in
            switch response {
            case let .success(receiptInfo):
                self?.output.didParsedReceipt(with: receiptInfo)
            case let .error(error):
                // TODO
                //output.didFailParseReceipt()
                break
            }
        }
    }
    
    func requestCategories() -> [Category] {
        return categoryService.getCategories()
    }
    
    func saveSpending(spendingInfo: SpendingInfo) {
        
        // TODO
        // FIX this part - incomprehensible code
        
        if spendingInfo.spending != nil {
            spendingService.updateSpending(withInfo: spendingInfo)
        } else {
            spendingService.addSpending(withInfo: spendingInfo)
        }
    }
    
}
