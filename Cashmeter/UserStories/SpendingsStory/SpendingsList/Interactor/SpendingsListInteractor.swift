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
    
    var spendingsListService: SpendingsListServiceInput!

}

// MARK: SpendingsListInteractorInput

extension SpendingsListInteractor: SpendingsListInteractorInput {
    
//    func requestSectionsCount() -> Int {
//        return spendingsListService.spendingsSectionsCount()
//    }
//
//    func requestRowsCount(in section: Int) -> Int {
//        return spendingsListService.spendingsCount(in: section)
//    }
//
//    func requestSpendingObject(at indexPath: IndexPath) -> Spending {
//        return spendingsListService.spendingAtIndexPath(indexPath)
//    }
	
}
