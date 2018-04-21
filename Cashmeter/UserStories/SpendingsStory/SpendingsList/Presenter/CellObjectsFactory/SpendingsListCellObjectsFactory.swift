//
//  SpendingsListSpendingsListCellObjectsFactory.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 21/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

final class SpendingsListCellObjectsFactory: SpendingsListCellObjectsFactoryInput {
    
    func convert(spending: Spending) -> TableCellObject {
        let cellObject = SpendingTableViewCellObject()
        
        cellObject.amount = spending.amount
        cellObject.categoryName = spending.category?.title
        
        return cellObject
    }

}
