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
    
    func convert(spendingInfo: SpendingInfo, categories: [Category]) -> [TableCellObject] {
        var cellObjects: [TableCellObject] = []
        
        var amountTableViewCellObject = AmountTableViewCellObject()
        amountTableViewCellObject.cellClass = AmountTableViewCell.self
        if spendingInfo.amount != 0 {
            amountTableViewCellObject.amount = spendingInfo.amount
        }
        cellObjects.append(amountTableViewCellObject)
        
        var categoriesTableViewCellObject = CategoriesTableViewCellObject()
        categoriesTableViewCellObject.cellClass = CategoriesTableViewCell.self
        categoriesTableViewCellObject.categories = categories
        cellObjects.append(categoriesTableViewCellObject)
        
        var dateTableViewCellObject = SpendingDateTableViewCellObject()
        dateTableViewCellObject.cellClass = SpendingDateTableViewCell.self
        dateTableViewCellObject.date = spendingInfo.date
        cellObjects.append(dateTableViewCellObject)
        
        if let receiptItems = spendingInfo.receiptItems, !receiptItems.isEmpty {
            var receiptItemsTableViewCellObject = SpendingReceiptItemsTableViewCellObject()
            receiptItemsTableViewCellObject.cellClass = SpendingReceiptItemsTableViewCell.self
            receiptItemsTableViewCellObject.receiptItemsDetailsText = textForReceiptItems(receiptItems)
            cellObjects.append(receiptItemsTableViewCellObject)
        } else {
            var receiptTableViewCellObject = AddReceiptTableViewCellObject()
            receiptTableViewCellObject.cellClass = AddReceiptTableViewCell.self
            cellObjects.append(receiptTableViewCellObject)
        }
        
        return cellObjects
    }
    
    private func textForReceiptItems(_ receiptItems: [SpendingItemInfo]) -> String {
        var text = ""
        for item in receiptItems {
            text.append(item.debugDescription)
        }
        return text
    }
    
}
