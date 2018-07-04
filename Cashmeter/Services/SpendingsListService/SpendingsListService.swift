//
//  SpendingsListService.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 21/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import CoreData

final class SpendingsListService: NSObject {
    
    var coreDataStack: CoreDataStack
    
    init(with coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        super.init()
    }
    
}

// MARK: NSFetchedResultsController

extension SpendingsListService: NSFetchedResultsControllerDelegate {
    
    func spendingsFetchedResultsController(with filter: Filter?) -> NSFetchedResultsController<Spending> {
        let fetchedResultController = NSFetchedResultsController(fetchRequest: spendingsFetchRequest(with: filter),
                                                                 managedObjectContext: coreDataStack.mainContext,
                                                                 sectionNameKeyPath: nil,
                                                                 cacheName: nil)
        fetchedResultController.delegate = self
        
        do {
            try fetchedResultController.performFetch()
        } catch let error as NSError {
            fatalError("Error: \(error.localizedDescription)")
        }
        
        return fetchedResultController
    }
    
    func spendingsFetchRequest(with filter: Filter?) -> NSFetchRequest<Spending> {
        let fetchRequest: NSFetchRequest<Spending> = Spending.fetchRequest()
        fetchRequest.fetchBatchSize = 20
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let filter = filter {   
            var predicates: [NSPredicate] = []
            if let fromDate = filter.fromDate {
                let fromDatePredicate = NSPredicate(format: "date >= %@", fromDate as NSDate)
                predicates.append(fromDatePredicate)
            }
            if let toDate = filter.toDate {
                let toDatePredicate = NSPredicate(format: "date <= %@", toDate as NSDate)
                predicates.append(toDatePredicate)
            }
            if let categories = filter.categories {
                var categoryPredicates: [NSPredicate] = []
                for category in categories {
                    let predicate = NSPredicate(format: "category.title == %@", category.title!)
                    categoryPredicates.append(predicate)
                }
                if !categoryPredicates.isEmpty {
                    predicates.append(NSCompoundPredicate(type: .or, subpredicates: categoryPredicates))
                }
            }
            if !predicates.isEmpty {
                fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
            }
        }
        
        return fetchRequest
    }
    
}
