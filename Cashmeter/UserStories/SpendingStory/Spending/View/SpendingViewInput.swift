
//
//  SpendingViewInput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

protocol SpendingViewInput: class {
    
    /**
     Метод настраивает начальное состояние view
     */
    func setupInitialState()
    
    /**
     Метод отображает контент модуля
     
     @param cellObjects - массив элементов для отображения
     */
    func showData(_ cellObjects: [TableCellObject])
    
    /**
     Метод показывает индикатор загрузки.
     */
    func showLoader()
    
    /**
     Метод скрывает индикатор загрузки.
     */
    func hideLoader()
    
}
