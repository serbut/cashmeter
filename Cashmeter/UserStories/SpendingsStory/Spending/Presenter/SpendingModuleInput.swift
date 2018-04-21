//
//  SpendingModuleInput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

protocol SpendingModuleInput {
    
    /**
     Метод настраивает модуль с покупкой
     
     @param spending - покупка
    */
    func setup(with spending: Spending)
    
}
