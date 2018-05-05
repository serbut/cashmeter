//
//  WalletService.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 04/05/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation
import CoreData

class WalletService {
    
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
    
    func addWallet(withName name: String,
                   currencyCode: String) {
        let wallet = Wallet(context: managedObjectContext)
        
        wallet.name = name
        // TODO: fetch currency
        
        save()
    }
    
    func addWallet(withName name: String,
                     currency: Currency) {
        let wallet = Wallet(context: managedObjectContext)
        
        wallet.name = name
        wallet.currency = currency
        
        save()
    }
    
    func getWallets() -> [Wallet] {
        let fetchRequest: NSFetchRequest<Wallet> = Wallet.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        var results = [Wallet]()
        do {
            results = try managedObjectContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return results
    }
    
}
