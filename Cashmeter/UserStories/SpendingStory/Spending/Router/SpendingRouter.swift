//
//  SpendingRouter.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

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
    
    func showErrorAlert(with message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: SpendingConstants.closeActionTitle, style: .cancel, handler: nil)
        alert.addAction(closeAction)
        
        transitionHandler.present(alert, animated: true, completion: nil)
    }
    
    func showAddCategoryModule(moduleOutput: NewCategoryModuleOutput) {
        let viewController = NewCategoryViewController()
        viewController.moduleOutput = moduleOutput
        let navVC = UINavigationController(rootViewController: viewController)
        
        transitionHandler.present(navVC, animated: true)
    }
    
    func showSelectWalletModule() {
        let viewController = SelectWalletViewController()
        
        transitionHandler.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showConfirmationDeleteAlert(completion: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: SpendingConstants.deleteActionTitle, preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: SpendingConstants.deleteActionYes, style: .destructive) { _ in
            completion()
        }
        let cancelAction = UIAlertAction(title: SpendingConstants.deleteActionNo, style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        transitionHandler.present(alert, animated: true, completion:nil)
    }
    
}
