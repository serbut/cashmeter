//
//  SpendingsListSpendingsListRouterInput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 21/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

protocol SpendingsListRouterInput: class {
    
    /**
     Метод открывает модуль покупки.
     
     @param spending - данные о покупке.
     */
    func showSpendingModule(_ spending: Spending)
    
    /**
     Метод открывает модуль фильтра.
     */
    func showFilterModule(moduleOutput: FilterModuleOutput)
    
}
