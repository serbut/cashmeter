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
    var fetchedResultsController: NSFetchedResultsController<Spending>!
    
    init(with coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        super.init()
        
        fetchedResultsController = spendingsFetchedResultsController()
    }
    
}

// MARK: NSFetchedResultsController

extension SpendingsListService: NSFetchedResultsControllerDelegate {
    
    func spendingsFetchedResultsController() -> NSFetchedResultsController<Spending> {
        let fetchedResultController = NSFetchedResultsController(fetchRequest: spendingsFetchRequest(),
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
    
    func spendingsFetchRequest() -> NSFetchRequest<Spending> {
        let fetchRequest: NSFetchRequest<Spending> = Spending.fetchRequest()
        fetchRequest.fetchBatchSize = 20
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
    }
    
}
