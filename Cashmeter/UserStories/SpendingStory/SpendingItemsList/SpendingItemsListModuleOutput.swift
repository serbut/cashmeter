//
//  SpendingItemsListModuleOutput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 13/05/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

protocol SpendingItemsListModuleOutput {
    
    /**
     Метод сообщает о том, что пользователь разделил позиции по категориям
     */
    func didSplitItems(_ items: [SpendingItemInfo])
    
}
