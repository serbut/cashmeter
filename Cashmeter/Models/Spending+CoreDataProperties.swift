//
//  Spending+CoreDataProperties.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 01/02/2018.
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
    @NSManaged public var date: Date?
    @NSManaged public var details: String?
    @NSManaged public var category: Category?
    @NSManaged public var currency: Currency?
    @NSManaged public var wallet: Wallet?

}
