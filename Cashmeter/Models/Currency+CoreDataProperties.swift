//
//  Currency+CoreDataProperties.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 01/02/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//
//

import Foundation
import CoreData

extension Currency {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Currency> {
        return NSFetchRequest<Currency>(entityName: "Currency")
    }

    @NSManaged public var label: String?
    @NSManaged public var name: String?
    @NSManaged public var spending: NSSet?

}

// MARK: Generated accessors for spending
extension Currency {

    @objc(addSpendingObject:)
    @NSManaged public func addToSpending(_ value: Spending)

    @objc(removeSpendingObject:)
    @NSManaged public func removeFromSpending(_ value: Spending)

    @objc(addSpending:)
    @NSManaged public func addToSpending(_ values: NSSet)

    @objc(removeSpending:)
    @NSManaged public func removeFromSpending(_ values: NSSet)

}
