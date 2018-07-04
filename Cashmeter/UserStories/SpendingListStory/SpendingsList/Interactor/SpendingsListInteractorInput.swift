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
     Метод вызывает удаление покупки.
     */
    func deleteSpending(_ spending: Spending)
    
}
