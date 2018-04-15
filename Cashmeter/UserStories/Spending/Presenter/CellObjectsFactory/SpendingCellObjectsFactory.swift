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
    
    func convert(spending: Spending?) -> [TableCellObject] {
        var cellObjects: [TableCellObject] = []
        
        var amountTableViewCellObject = AmountTableViewCellObject()
        amountTableViewCellObject.cellClass = AmountTableViewCell.self
        amountTableViewCellObject.amount = spending?.amount
        cellObjects.append(amountTableViewCellObject)
        
        var receiptTableViewCellObject = ReceiptTableViewCellObject()
        receiptTableViewCellObject.cellClass = ReceiptTableViewCell.self
        cellObjects.append(receiptTableViewCellObject)
        
        return cellObjects
    }
    
}
