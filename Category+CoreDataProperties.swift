//
//  Category+CoreDataProperties.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 24/01/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var icon: String?
    @NSManaged public var title: String?
    @NSManaged public var spending: NSSet?

}

// MARK: Generated accessors for spending
extension Category {

    @objc(addSpendingObject:)
    @NSManaged public func addToSpending(_ value: Spending)

    @objc(removeSpendingObject:)
    @NSManaged public func removeFromSpending(_ value: Spending)

    @objc(addSpending:)
    @NSManaged public func addToSpending(_ values: NSSet)

    @objc(removeSpending:)
    @NSManaged public func removeFromSpending(_ values: NSSet)

}
