//
//  InitialDataFillerService.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 05/05/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation

final class InitialDataFillerService {
    
    let servicesAssembly: ServicesAssembly
    let categoryService: CategoryService
    let walletService: WalletService
    let currencyService: CurrencyService
    
    init() {
        servicesAssembly = ServicesAssembly()
        categoryService = servicesAssembly.categoryService()
        walletService = servicesAssembly.walletService()
        currencyService = servicesAssembly.currencyService()
    }
    
    func addInitialData() {
        addDefaultCategories()
        addDefaultCurrencies()
        addDefaultWallets()
    }
    
    private func addDefaultCategories() {
        if UserDefaults.standard.bool(forKey: "categoriesLoaded") { return }
        
        let path = Bundle.main.path(forResource: "DefaultCategories",
                                    ofType: "plist")
        let dataArray = NSArray(contentsOfFile: path!)!
        for dict in dataArray {
            let categoryDict = dict as! [String: AnyObject]
            let imageName = categoryDict["image_name"] as! String
            let title = categoryDict["title"] as! String
            categoryService.addCategory(withTitle: title, imageName: imageName)
        }
        UserDefaults.standard.set(true, forKey: "categoriesLoaded")
    }
    
    private func addDefaultCurrencies() {
        if UserDefaults.standard.bool(forKey: "currenciesLoaded") { return }
        
        let path = Bundle.main.path(forResource: "DefaultCurrencies",
                                    ofType: "plist")
        let dataArray = NSArray(contentsOfFile: path!)!
        for dict in dataArray {
            let currencyDict = dict as! [String: AnyObject]
            let code = currencyDict["code"] as! String
            let name = currencyDict["name"] as! String
            let label = currencyDict["label"] as! String
            currencyService.addCurrency(withName: name, code: code, label: label)
        }
        UserDefaults.standard.set(true, forKey: "currenciesLoaded")
    }
    
    private func addDefaultWallets() {
        if UserDefaults.standard.bool(forKey: "walletsLoaded") { return }
        
        let path = Bundle.main.path(forResource: "DefaultWallets",
                                    ofType: "plist")
        let dataArray = NSArray(contentsOfFile: path!)!
        for dict in dataArray {
            let walletDict = dict as! [String: AnyObject]
            let name = walletDict["name"] as! String
            let currencyCode = walletDict["currency"] as! String
            guard let currency = currencyService.getCurrency(by: currencyCode) else {
                print("Can't find currency with code: \(currencyCode)")
                return
            }
            walletService.addWallet(withName: name, currency: currency, balance: 0)
        }
        UserDefaults.standard.set(true, forKey: "walletsLoaded")
    }
    
}
