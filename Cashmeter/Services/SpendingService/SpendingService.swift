//
//  SpendingService.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 01/02/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation
import CoreData

final class SpendingService {
    
    // MARK: Properties
    
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
   
    func updateSpending(_ spending: Spending,
                        withAmount amount: Double,
                        category: Category,
                        details: String?) {
        spending.amount = amount
        spending.category = category
        spending.details = details
    }
    
}

// MARK: SpendingServiceInput

extension SpendingService: SpendingServiceInput {
    
    func addSpending(withInfo spendingInfo: SpendingInfo) {
        let spending = Spending(context: managedObjectContext)
        spending.amount = spendingInfo.amount
        spending.category = spendingInfo.category
        spending.date = spendingInfo.date
        spending.details = spendingInfo.comment
        
        if let receiptItems = spendingInfo.receiptItems {
            for itemInfo in receiptItems {
                let item = SpendingItem(context: managedObjectContext)
                item.title = itemInfo.name
                item.price = itemInfo.price
                item.quantity = itemInfo.quantity
                item.sum = itemInfo.sum
                item.spending = spending
                spending.items?.adding(item)
            }
        }
        
        
        managedObjectContext.perform {
            do {
                try self.managedObjectContext.save()
            } catch let error as NSError {
                fatalError(error.localizedDescription)
            }
            self.coreDataStack.saveContext()
        }
    }
    
}
