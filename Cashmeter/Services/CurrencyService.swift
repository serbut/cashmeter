//
//  CurrencyService.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 05/05/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation
import CoreData

final class CurrencyService {
    
    // MARK: Properties
    
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
    
    fileprivate func save() {
        managedObjectContext.perform {
            do {
                try self.managedObjectContext.save()
            } catch let error as NSError {
                fatalError(error.localizedDescription)
            }
            self.coreDataStack.saveContext()
        }
    }
    
    func addCurrency(withName name: String,
                   code: String,
                   label: String) {
        let currency = Currency(context: managedObjectContext)
        
        currency.name = name
        currency.label = label
        currency.code = code
        
        save()
    }
    
    func getCurrencies() -> [Currency] {
        let fetchRequest: NSFetchRequest<Currency> = Currency.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        var results = [Currency]()
        do {
            results = try managedObjectContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return results
    }
    
    func getCurrency(by code: String) -> Currency? {
        let fetchRequest: NSFetchRequest<Currency> = Currency.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "code = %@", code)
        var currency: Currency?
        do {
            currency = try managedObjectContext.fetch(fetchRequest).first
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return currency
    }
    
}
