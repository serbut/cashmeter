//
//  SpendingsListSpendingsListViewInput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 21/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

protocol SpendingsListViewInput: class {

    /**
     Метод настраивает начальное состояние view.
     */
    func setupInitialState()

    /**
     Метод отображает контент коллекции.
     
     @param cellObjects - массив cellObject-ов.
     */
    func show(cellObjects: [TableCellObject])
    
    /**
     Метод перезагружает коллекцию.
     */
    func reload()
    
}
