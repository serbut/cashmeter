//
//  TestCoreDataStack.swift
//  CashmeterTests
//
//  Created by Sergey Butorin on 01/02/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation
@testable import Cashmeter
import CoreData

class TestCoreDataStack: CoreDataStack {
    
    convenience init() {
        self.init(modelName: "Cashmeter")
    }
    
    override init(modelName: String) {
        super.init(modelName: modelName)
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: modelName)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error \(error.localizedDescription)")
            }
        }
        self.storeContainer = container
    }
}
