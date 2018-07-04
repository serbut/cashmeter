//
//  SpendingCellObjectsFactoryInput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

protocol SpendingCellObjectsFactoryInput: class {
    
    /**
     Метод конвертирует данные о покупке в cellObject-ы.
     
     @param spendingInfo - объект, который надо сконвертировать в cellObject-ы.
     
     @param categories - массив категорий.
     
     @return sectionObject-ы.
     */
    func convert(spendingInfo: SpendingInfo, categories: [Category]) -> [TableCellObject]
    
}
