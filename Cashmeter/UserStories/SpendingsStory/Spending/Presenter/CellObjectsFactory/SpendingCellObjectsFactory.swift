//
//  SpendingCellObjectsFactory.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

final class SpendingCellObjectsFactory {
    
}

// MARK: SpendingCellObjectsFactoryInput

extension SpendingCellObjectsFactory: SpendingCellObjectsFactoryInput {
    
    func convert(spending: Spending, categories: [Category]) -> [TableCellObject] {
        var cellObjects: [TableCellObject] = []
        
        var amountTableViewCellObject = AmountTableViewCellObject()
        amountTableViewCellObject.cellClass = AmountTableViewCell.self
        amountTableViewCellObject.amount = spending.amount
        cellObjects.append(amountTableViewCellObject)
        
        var categoriesTableViewCellObject = CategoriesTableViewCellObject()
        categoriesTableViewCellObject.cellClass = CategoriesTableViewCell.self
        categoriesTableViewCellObject.categories = categories
        cellObjects.append(categoriesTableViewCellObject)
        
        var receiptTableViewCellObject = AddReceiptTableViewCellObject()
        receiptTableViewCellObject.cellClass = AddReceiptTableViewCell.self
        cellObjects.append(receiptTableViewCellObject)
        
        return cellObjects
    }
    
    func createForNewSpending(categories: [Category]) -> [TableCellObject] {
        var cellObjects: [TableCellObject] = []

        var amountTableViewCellObject = AmountTableViewCellObject()
        amountTableViewCellObject.cellClass = AmountTableViewCell.self
        cellObjects.append(amountTableViewCellObject)
        
        var categoriesTableViewCellObject = CategoriesTableViewCellObject()
        categoriesTableViewCellObject.cellClass = CategoriesTableViewCell.self
        categoriesTableViewCellObject.categories = categories
        cellObjects.append(categoriesTableViewCellObject)
        
        var dateTableViewCellObject = SpendingDateTableViewCellObject()
        dateTableViewCellObject.cellClass = SpendingDateTableViewCell.self
        cellObjects.append(dateTableViewCellObject)
        
        var receiptTableViewCellObject = AddReceiptTableViewCellObject()
        receiptTableViewCellObject.cellClass = AddReceiptTableViewCell.self
        cellObjects.append(receiptTableViewCellObject)
        
        return cellObjects
    }
    
}
