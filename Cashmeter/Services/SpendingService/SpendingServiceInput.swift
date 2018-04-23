//
//  SpendingServiceInput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 22/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation

protocol SpendingServiceInput {
    
    /**
     Метод добавляет информацию о покупке.
     
     @param spendingInfo - информация о покупке.
     */
    func addSpending(withInfo spendingInfo: SpendingInfo)
    
    /**
     Метод обновляет информацию о покупке.
     
     @param spendingInfo - информация о покупке.
     */
    func updateSpending(withInfo spendingInfo: SpendingInfo)
    
}
