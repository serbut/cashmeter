//
//  SpendingsListSpendingsListRouter.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 21/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

final class SpendingsListRouter {

	weak var transitionHandler: SpendingsListViewController!

}

// MARK: SpendingsListRouterInput

extension SpendingsListRouter: SpendingsListRouterInput {
    
    func showSpendingModule(_ spending: Spending) {
        let configurator = SpendingConfigurator()
        let module = configurator.spendingModule()
        let viewController = module.viewController
        let moduleInput = module.moduleInput as? SpendingModuleInput
        moduleInput?.setup(with: spending)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        transitionHandler.present(navigationController, animated: true, completion: nil)
    }
    
    func showFilterModule() {
        let viewController = FilterViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        transitionHandler.present(navigationController, animated: true, completion: nil)
    }
	
}
