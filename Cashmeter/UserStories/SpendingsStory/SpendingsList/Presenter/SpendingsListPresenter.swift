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
    var cellObjectsFactory: SpendingsListCellObjectsFactoryInput!
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
    
    func didSelectRowAt(indexPath: IndexPath) {
        let spending = interactor.requestSpendingObject(at: indexPath)
        // TODO: Move to completion
        router.showSpendingModule(spending)
    }
    
    func requestSectionsCount() -> Int {
        return interactor.requestSectionsCount()
    }
    
    func requestRowsCount(in section: Int) -> Int {
        return interactor.requestRowsCount(in: section)
    }
    
    func requestCellObject(at indexPath: IndexPath) -> TableCellObject {
        let spending = interactor.requestSpendingObject(at: indexPath)
        return cellObjectsFactory.convert(spending: spending)
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
