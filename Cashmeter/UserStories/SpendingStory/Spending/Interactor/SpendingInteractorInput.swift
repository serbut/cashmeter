//
//  SpendingInteractorInput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

protocol SpendingInteractorInput {
    
    /**
     Метод отправляет запрос на расшифровку чека.
     
     @param receipt - данные чека.
     */
    func parseReceipt(_ receipt: ReceiptData)
    
    /**
     Метод запрашивает категории.
     */
    func requestCategories() -> [Category]
    
    /**
     Метод сохраняет покупку.
     */
    func saveSpending(spendingInfo: SpendingInfo)
    
    /**
     Метод вызывает удаление покупки.
     */
    func deleteSpending(_ spending: Spending)
    
}
