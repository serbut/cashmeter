//
//  SpendingPresenter.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation

final class SpendingPresenter {
    
    weak var view: SpendingViewInput!
    var interactor: SpendingInteractorInput!
    var router: SpendingRouterInput!
    var output: SpendingModuleOutput?
    var cellObjectsFactory: SpendingCellObjectsFactoryInput!
    
    
    var spending: Spending?
    
}

// MARK: SpendingModuleInput

extension SpendingPresenter: SpendingModuleInput {
    
    func setup(with spending: Spending) {
        self.spending = spending
    }
    
}

// MARK: SpendingViewOutput

extension SpendingPresenter: SpendingViewOutput {
    
    func viewIsReady() {
        view.setupInitialState()
        let cellObjects = cellObjectsFactory.convert(spending: spending)
        view.showData(cellObjects)
    }
    
    func didTapButton(with type: SpendingButtonType) {
        print("Tap button")
    }
    
    func didTriggerScanQrAction() {
        router.showScanQrModule()
    }
    
}
