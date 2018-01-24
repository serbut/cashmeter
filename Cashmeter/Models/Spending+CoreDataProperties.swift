//
//  Spending+CoreDataProperties.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 24/01/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//
//

import Foundation
import CoreData


extension Spending {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Spending> {
        return NSFetchRequest<Spending>(entityName: "Spending")
    }

    @NSManaged public var amount: Double
    @NSManaged public var details: String?
    @NSManaged public var category: Category?

}
