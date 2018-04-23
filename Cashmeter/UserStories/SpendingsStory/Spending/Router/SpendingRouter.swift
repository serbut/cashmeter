//
//  SpendingRouter.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

final class SpendingRouter: SpendingRouterInput {
    
    weak var transitionHandler: SpendingViewController!
    
    func showScanQrModule(moduleOutput: QRScannerModuleOutput) {
        let viewController = QRScannerViewController()
        viewController.moduleOutput = moduleOutput
        transitionHandler.present(viewController, animated: true, completion: nil)
    }
    
    func showItemsList(spendingItems: [SpendingItemInfo]) {
        let viewController = SpendingItemsListViewController()
        viewController.spendingItems = spendingItems
        transitionHandler.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func closeModule() {
        transitionHandler.dismiss(animated: true, completion: nil)
    }
    
}
