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
    
    var spendingInfo = SpendingInfo()
    
    fileprivate func updateUI() {
        var cellObjects: [TableCellObject] = []
        let categories = interactor.requestCategories()
        cellObjects = cellObjectsFactory.convert(spendingInfo: spendingInfo, categories: categories)
        view.showData(cellObjects)
    }
    
}

// MARK: SpendingModuleInput

extension SpendingPresenter: SpendingModuleInput {
    
    func setup(with spending: Spending) {
        spendingInfo = SpendingInfo(from: spending)
        view.showDeleteButton(true)
    }
    
}

// MARK: SpendingViewOutput

extension SpendingPresenter: SpendingViewOutput {
    
    func viewIsReady() {
        view.setupInitialState()

        updateUI()
    }
    
    func didTriggerScanQrAction() {
        router.showScanQrModule(moduleOutput: self)
    }
    
    func didTriggerShowSpendingItemsAction() {
        guard let spendingItems = spendingInfo.items else { return }
        router.showItemsList(spendingItems: spendingItems, moduleOutput: self)
    }
    
    func didTriggerSelectWalletAction() {
        router.showSelectWalletModule(moduleOutput: self)
    }
    
    func didTapOnClose() {
        router.closeModule()
    }
    
    func didTapOnDelete() {
        router.showConfirmationDeleteAlert { [weak self] in
            guard let spending = self?.spendingInfo.spending else {
                fatalError("Trying to delete spending which doesn't exists")
            }
            self?.interactor.deleteSpending(spending)
            // TODO: move to completion
            self?.router.closeModule()
        }
    }
    
    func didTapOnSave() {
        guard spendingInfo.amount > 0 else {
            router.showAlert(with: SpendingConstants.fillAmountError)
            return
        }
        interactor.saveSpending(spendingInfo: spendingInfo)
        // TODO: move to completion
        router.closeModule()
    }
    
    func didChangeAmountValue(_ value: String?) {
        guard let value = value, let amount = Double(value) else {
            spendingInfo.amount = 0
            return
        }
        spendingInfo.amount = amount
    }
    
    func didChangeDateValue(_ value: Date?) {
        guard let value = value else { return }
        spendingInfo.date = value
    }
    
    func didChangeComment(_ comment: String?) {
        guard let comment = comment else { return }
        spendingInfo.comment = comment
    }
    
    func didSelectCategory(_ category: Category?) {
        spendingInfo.category = category
    }
    
    func didTapAddCategory() {
        router.showAddCategoryModule(moduleOutput: self)
    }
    
}

// MARK: SpendingInteractorOutput

extension SpendingPresenter: SpendingInteractorOutput {
    
    func didParsedReceipt(with receiptInfo: ReceiptInfo) {
        view.hideLoader()
        
        spendingInfo.amount = receiptInfo.sum
        spendingInfo.items = receiptInfo.items.map { SpendingItemInfo(from: $0) }
        
        var cellObjects: [TableCellObject] = []
        let categories = interactor.requestCategories()
        cellObjects = cellObjectsFactory.convert(spendingInfo: spendingInfo, categories: categories)
        view.showData(cellObjects)
    }
    
    func didFailParseReceipt(error: String) {
        view.hideLoader()
        router.showAlert(with: SpendingConstants.errorGetReceiptAlertText)
    }
    
}

// MARK: QRScannerModuleOutput

extension SpendingPresenter: QRScannerModuleOutput {
    
    func scanIsFinished(_ scannedString: String) {
        guard let receiptData = ReceiptData(fromQrString: scannedString) else {
            router.showAlert(with: SpendingConstants.errorParseQrAlertText) // TODO: move and process error
            return
        }
        if let dateTime = receiptData.dateTime {
            spendingInfo.date = dateTime
        }
        if let amount = receiptData.amount {
            spendingInfo.amount = amount
        }
        updateUI()
        view.showLoader()
                
        interactor.parseReceipt(receiptData)
    }
    
}

// MARK: NewCategoryModuleOutput

extension SpendingPresenter: NewCategoryModuleOutput {
    
    func didAddCategory() {
        updateUI()
    }
    
}

// MARK: SelectWalletModuleOutput

extension SpendingPresenter: SelectWalletModuleOutput {
    
    func didSelectWallet(_ wallet: Wallet) {
        spendingInfo.wallet = wallet
        spendingInfo.currencySign = spendingInfo.wallet!.currency!.label!
        updateUI()
    }
    
}

// MARK: SpendingItemsListModuleOutput

extension SpendingPresenter: SpendingItemsListModuleOutput {
    
    func didSplitItems(_ items: [SpendingItemInfo]) {
        spendingInfo.items = items
        // TODO: maybe only needed to update categories cell
        updateUI()
    }
    
}
