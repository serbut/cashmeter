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
     Метод перезагружает коллекцию.
     */
    func reload()
    
}
