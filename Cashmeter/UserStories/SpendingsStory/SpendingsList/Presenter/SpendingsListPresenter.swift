//
//  SpendingsListSpendingsListPresenter.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 21/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation

final class SpendingsListPresenter {

    weak var view: SpendingsListViewInput!
    var interactor: SpendingsListInteractorInput!
    var router: SpendingsListRouterInput!
    
}

// MARK: SpendingsListModuleInput

extension SpendingsListPresenter: SpendingsListModuleInput {
	
}

// MARK: SpendingsListViewOutput

extension SpendingsListPresenter: SpendingsListViewOutput {
	
    func viewDidLoad() {
        view.setupInitialState()
    }
    
    func didSelectSpending(spending: Spending) {
        router.showSpendingModule(spending)
    }
    
    func didTapFilterButton() {
        print("Filter")
    }

}

// MARK: SpendingsListInteractorOutput

extension SpendingsListPresenter: SpendingsListInteractorOutput {
    
    func contentChanged() {
        view.reload()
    }
    
}
