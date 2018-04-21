//
//  SpendingsListSpendingsListCellObjectsFactoryInput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 21/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

protocol SpendingsListCellObjectsFactoryInput: class {
	
	/**
     Метод конвертирует данные о покупке в cellObject.
     
     @param spending - объект, который надо сконвертировать в cellObject.
     
     @return sectionObject.
     */
    func convert(spending: Spending) -> TableCellObject

}
