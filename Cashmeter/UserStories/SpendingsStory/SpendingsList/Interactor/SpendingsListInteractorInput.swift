//
//  SpendingsListSpendingsListInteractorInput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 21/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation

protocol SpendingsListInteractorInput: class {
	
    /**
     Метод запрашивает количество секций.
     */
    func requestSectionsCount() -> Int
    
    /**
     Метод запрашивает количество ячеек в секции.
     
     @param section - номер секции.
     */
    func requestRowsCount(in section: Int) -> Int
    
    /**
     Метод запрашивает данные о покупке.
     
     @param indexPath - индекс ячейки.
     */
    func requestSpendingObject(at indexPath: IndexPath) -> Spending
    
}
