//
//  SpendingsListSpendingsListInteractor.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 21/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation

final class SpendingsListInteractor {

    weak var output: SpendingsListInteractorOutput!
    
    var spendingService: SpendingServiceInput!
    
}

// MARK: SpendingsListInteractorInput

extension SpendingsListInteractor: SpendingsListInteractorInput {
	
    func deleteSpending(_ spending: Spending) {
        spendingService.deleteSpending(spending)
    }
    
}
