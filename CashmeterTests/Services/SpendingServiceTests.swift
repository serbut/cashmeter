//
//  SpendingServiceTests.swift
//  CashmeterTests
//
//  Created by Sergey Butorin on 01/02/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import XCTest
import CoreData
@testable import Cashmeter

class SpendingServiceTests: XCTestCase {
    
    // MARK: Properties
    var spendingService: SpendingService!
    var categoryService: CategoryService!
    var coreDataStack: CoreDataStack!
    
    override func setUp() {
        super.setUp()
        
        coreDataStack = TestCoreDataStack()
        spendingService = SpendingService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
        categoryService = CategoryService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        
        coreDataStack = nil
        spendingService = nil
        categoryService = nil
    }
    
    func testAddSpending() {
        let title = "Test Category"
        let icon = "😀"
        
        let category = categoryService.addCategory(withTitle: title, icon: icon)
        
        let amount = 100.0
        let details = "Test description"
        
        let spending = spendingService.addSpending(withAmount: amount, category: category, details: details)
        
        XCTAssertEqual(spending.amount, amount)
        XCTAssertEqual(spending.category, category)
        XCTAssertEqual(spending.details, spending.details)
    }
    
}
