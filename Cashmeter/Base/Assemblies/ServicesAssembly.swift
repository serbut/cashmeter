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
    
    func categoryService() -> CategoryService {
        let stack = coreDataStack()
        let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        childContext.parent = stack.mainContext
        let categoryService = CategoryService(managedObjectContext: childContext, coreDataStack: stack)
        
        return categoryService
    }
    
    private func coreDataStack() -> CoreDataStack {
        return (UIApplication.shared.delegate as? AppDelegate)!.coreDataStack
    }
}
