//
//  ServicesAssembly.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit
import CoreData

final class ServicesAssembly {
    
    func receiptService() -> ReceiptService {
        let receiptService = ReceiptService()
        
        receiptService.networkProvider = networkProvider()
        
        return receiptService
    }
    
    func networkProvider() -> NetworkProviderProtocol {
        let networkProvider = NetworkProvider()
        
        return networkProvider
    }
    
    func spendingsListService() -> SpendingsListService {
        let stack = coreDataStack()
        let spendingsListService = SpendingsListService(with: stack)
        
        return spendingsListService
    }
    
    func spendingService() -> SpendingServiceInput {
        let stack = coreDataStack()
//        let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//        childContext.parent = stack.mainContext
        let spendingService = SpendingService(managedObjectContext: stack.mainContext, coreDataStack: stack)
        
        return spendingService
    }
    
    func categoryService() -> CategoryService {
        let stack = coreDataStack()
//        let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//        childContext.parent = stack.mainContext
        let categoryService = CategoryService(managedObjectContext: stack.mainContext, coreDataStack: stack)
        
        return categoryService
    }
    
    func walletService() -> WalletService {
        let stack = coreDataStack()
        
        let walletService = WalletService(managedObjectContext: stack.mainContext, coreDataStack: stack)
        
        return walletService
    }
    
    func currencyService() -> CurrencyService {
        let stack = coreDataStack()
        
        let currencyService = CurrencyService(managedObjectContext: stack.mainContext, coreDataStack: stack)
        
        return currencyService
    }
    
    private func coreDataStack() -> CoreDataStack {
        return (UIApplication.shared.delegate as? AppDelegate)!.coreDataStack
    }
}
