//
//  CategoryService.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 01/02/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation
import CoreData

class CategoryService {
    
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
    
    func addCategory(withTitle title: String,
                     image_name: String) {
        let category = Category(context: managedObjectContext)
        
        category.title = title
        category.image_name = image_name
        
        save()
    }
    
    func getCategories() -> [Category] {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        var results = [Category]()
        do {
            results = try managedObjectContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return results
    }
    
}
