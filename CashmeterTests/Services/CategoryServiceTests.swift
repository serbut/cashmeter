//
//  CategoryServiceTests.swift
//  CashmeterTests
//
//  Created by Sergey Butorin on 01/02/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import XCTest
import CoreData
@testable import Cashmeter

class CategoryServiceTests: XCTestCase {
    
    // MARK: Properties
    var categoryService: CategoryService!
    var coreDataStack: CoreDataStack!
    
    override func setUp() {
        super.setUp()
        
        coreDataStack = TestCoreDataStack()
        categoryService = CategoryService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        
        coreDataStack = nil
        categoryService = nil
    }
    
    func testAddCategory() {
        let title = "Test Category"
        let icon = "😀"
        
        let category = categoryService.addCategory(withTitle: title, icon: icon)

        XCTAssertEqual(category.title, title)
        XCTAssertEqual(category.icon, icon)
    }

}
