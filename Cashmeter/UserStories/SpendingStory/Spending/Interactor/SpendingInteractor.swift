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
    var walletService: WalletService!
    
}

// MARK: SpendingInteractorInput

extension SpendingInteractor: SpendingInteractorInput {
    
    func parseReceipt(_ receipt: ReceiptData) {
        receiptService.parse(receipt) { [weak self] (response: ServiceResponse<ReceiptInfo>) in
            switch response {
            case let .success(receiptInfo):
                self?.output.didParsedReceipt(with: receiptInfo)
            case let .error(error):
                self?.output.didFailParseReceipt(error: error.localizedDescription)
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
            updateWalletBalance(spendingInfo: spendingInfo)
            spendingService.updateSpending(withInfo: spendingInfo)
        } else {
            updateWalletBalance(spendingInfo: spendingInfo)
            spendingService.addSpending(withInfo: spendingInfo)
        }
    }
    
    private func updateWalletBalance(spendingInfo: SpendingInfo) {
        let wallet = spendingInfo.wallet
        if let wallet = wallet {
            if let spending = spendingInfo.spending,
                spendingInfo.amount != spending.amount {
                // If spending already exists
                // And amount changed
                // Update amount
                let diff = spendingInfo.amount - spending.amount
                walletService.updateBalance(wallet, amount: diff, isIncome: false)
            } else {
                walletService.updateBalance(wallet, amount: spendingInfo.amount, isIncome: false)
            }
        }
    }
    
    func deleteSpending(_ spending: Spending) {
        spendingService.deleteSpending(spending)
        // Returning money to wallet if it was set
        if let wallet = spending.wallet {
            walletService.updateBalance(wallet, amount: spending.amount, isIncome: true)
        }
    }
    
}
