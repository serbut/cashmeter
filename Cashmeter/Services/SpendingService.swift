//
//  SpendingService.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 01/02/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation
import CoreData

class SpendingService {
    // MARK: Properties
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
    
    func addSpending(withAmount amount: Double,
                     category: Category,
                     details: String?) -> Spending {
        let spending = Spending(context: managedObjectContext)
        spending.amount = amount
        spending.category = category
        spending.details = details
        spending.date = Date()
        
        return spending
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
