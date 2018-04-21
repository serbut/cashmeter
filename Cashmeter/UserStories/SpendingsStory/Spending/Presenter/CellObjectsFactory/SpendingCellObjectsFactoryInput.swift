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
     
     @param spending - объект, который надо сконвертировать в cellObject-ы.
     
     @return sectionObject-ы.
     */
    func convert(spending: Spending) -> [TableCellObject]
    
    /**
     Метод создает cellObject-ы для новой покупки.
     */
    func createForNewSpending() -> [TableCellObject]
    
}
