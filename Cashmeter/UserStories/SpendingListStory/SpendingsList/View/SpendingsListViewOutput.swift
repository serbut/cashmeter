//
//  SpendingsListSpendingsListViewOutput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 21/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation

protocol SpendingsListViewOutput: class {

    /**
     Метод сообщает о том, что view загрузилась.
     */
    func viewDidLoad()
    
    /**
     Метод сообщает о том, что была нажата ячейка.
     */
    func didSelectSpending(spending: Spending)
    
    /**
     Метод сообщает о том, что была нажата кнопка фильтра.
     */
    func didTapFilterButton()
    
    /**
     Метод сообщает о том, что было инициировано удаление покупки.
     */
    func didTriggerDeleteAction(_ spending: Spending)

}
