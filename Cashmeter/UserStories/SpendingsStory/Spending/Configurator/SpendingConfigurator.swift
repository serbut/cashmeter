//
//  SpendingConfigurator.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

final class SpendingConfigurator {
    
    let servicesAssembly = ServicesAssembly()
    
    func spendingModule() -> Module {
        let viewController = self.configureViewController()
        let presenter = self.configurePresenter()
        let interactor = self.configureInteractor()
        let router = self.configureRouter()
        
        viewController.output = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        router.transitionHandler = viewController
        
        let module = AssembledModule(viewController: viewController, moduleInput: presenter)
        return module
    }
    
    private func configureViewController() -> SpendingViewController {
        let viewController = SpendingViewController()
        let dataDisplayManager = self.dataDisplayManager()
        
        dataDisplayManager.output = viewController
        viewController.dataDisplayManager = dataDisplayManager
        
        return viewController
    }
    
    private func configurePresenter() -> SpendingPresenter {
        let presenter = SpendingPresenter()
        
        presenter.cellObjectsFactory = cellObjectsFactory()
        
        return presenter
    }
    
    private func configureInteractor() -> SpendingInteractor {
        let interactor = SpendingInteractor()
        
        interactor.receiptService = servicesAssembly.receiptService()
        interactor.spendingService = servicesAssembly.spendingService()
        interactor.categoryService = servicesAssembly.categoryService()
        
        return interactor
    }
    
    private func configureRouter() -> SpendingRouter {
        let router = SpendingRouter()
        
        return router
    }
    
    private func dataDisplayManager() -> SpendingDataDisplayManager {
        let dataDisplayManager = SpendingDataDisplayManager()
        
        return dataDisplayManager
    }
    
    private func cellObjectsFactory() -> SpendingCellObjectsFactory {
        let cellObjectsFactory = SpendingCellObjectsFactory()
        
        return cellObjectsFactory
    }
}
