//
//  CoreDataStack.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 28/01/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import CoreData

class CoreDataStack {
    
    // MARK: Properties
    fileprivate let modelName: String
    
    lazy var mainContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    lazy var storeContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()
    
    // MARK: Initializers
    init(modelName: String) {
        self.modelName = modelName
    }
}

// MARK: Internal
extension CoreDataStack {
    
    func saveContext () {
        guard mainContext.hasChanges else { return }
        
        do {
            try mainContext.save()
        } catch let nserror as NSError {
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
