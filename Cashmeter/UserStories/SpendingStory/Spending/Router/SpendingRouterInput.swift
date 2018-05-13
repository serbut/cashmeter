//
//  SpendingRouterInput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

protocol SpendingRouterInput: class {
    
    /**
     Метод открывает модуль сканирования QR-кодов
     */
    func showScanQrModule(moduleOutput: QRScannerModuleOutput)
    
    /**
     Метод открывает модуль со списком позиций в покупке.
     */
    func showItemsList(spendingItems: [SpendingItemInfo], moduleOutput: SpendingItemsListModuleOutput)
    
    /**
     Метод открывает модуль выбора кошелька.
     */
    func showSelectWalletModule(moduleOutput: SelectWalletModuleOutput)
    
    /**
     Метод закрывает модуль.
     */
    func closeModule()
    
    /**
     Метод показывает ошибку при невозможности получения чека.
     */
    func showErrorAlert(with message: String)
    
    /**
     Метод открывает модуль добавления новой категории.
     */
    func showAddCategoryModule(moduleOutput: NewCategoryModuleOutput)
    
    /**
     Метод показывает алерт перед удалением покупки.
     */
    func showConfirmationDeleteAlert(completion: @escaping () -> Void)
    
}
