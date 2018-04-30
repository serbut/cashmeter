//
//  SpendingsListSpendingsListConfigurator.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 21/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

final class SpendingsListModuleConfigurator {

    let servicesAssembly = ServicesAssembly()
    
    func buildModule() -> Module {
        let viewController = configureViewController()
        let presenter = configurePresenter()
        let interactor = configureInteractor()
        let router = configureRouter()

        viewController.output = presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.output = presenter

        router.transitionHandler = viewController

        let module = AssembledModule(viewController: viewController, moduleInput: presenter)

        return module
    }

    private func configureViewController() -> SpendingsListViewController {
        let viewController =  SpendingsListViewController()
        let displayManager = configureDisplayManager()

        viewController.displayManager = displayManager
        displayManager.output = viewController

        return viewController
    }

    private func configureDisplayManager() -> SpendingsListDisplayManager {
        let displayManager = SpendingsListDisplayManager()
        let service = servicesAssembly.spendingsListService()
        displayManager.fetchedResultsController = service.fetchedResultsController
//        displayManager.fetchedResultsController.delegate = displayManager
        return displayManager
    }

    private func configurePresenter() -> SpendingsListPresenter {
        let presenter =  SpendingsListPresenter()

        return presenter
    }

    private func configureInteractor() -> SpendingsListInteractor {
        let interactor =  SpendingsListInteractor()
        interactor.spendingsListService = servicesAssembly.spendingsListService()

        return interactor
    }

    private func configureRouter() -> SpendingsListRouter {
        let router =  SpendingsListRouter()

        return router
    }

}
