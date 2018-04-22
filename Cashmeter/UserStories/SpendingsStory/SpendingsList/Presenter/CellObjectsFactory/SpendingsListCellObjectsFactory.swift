//
//  SpendingsListSpendingsListCellObjectsFactory.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 21/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

final class SpendingsListCellObjectsFactory: SpendingsListCellObjectsFactoryInput {
    
    let noCategoryTitle = "No category"
    let noCategoryImageName = "undefined_category"
    
    func convert(spending: Spending) -> TableCellObject {
        let cellObject = SpendingListTableViewCellObject()
        
        cellObject.cellClass = SpendingListTableViewCell.self
        cellObject.amount = spending.amount
        cellObject.categoryName = spending.category?.title ?? noCategoryTitle
        cellObject.categoryImageName = spending.category?.image_name ?? noCategoryImageName
        
        return cellObject
    }

}
