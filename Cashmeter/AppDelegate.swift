//
//  AppDelegate.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 08/01/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var coreDataStack = CoreDataStack(modelName: "Cashmeter")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        _ = coreDataStack.mainContext
        
        addDefaultCategories()
        addDefaultCurrencies()
        addDefaultWallets()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let tabController = MainTabBarViewController()
        tabController.coreDataStack = coreDataStack

        window?.rootViewController = tabController

        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        coreDataStack.saveContext()
    }
    
    private func addDefaultCategories() {
        if UserDefaults.standard.bool(forKey: "categoriesLoaded") { return }
        
        let path = Bundle.main.path(forResource: "DefaultCategories",
                                    ofType: "plist")
        let dataArray = NSArray(contentsOfFile: path!)!
        for dict in dataArray {
            let category = Category(context: coreDataStack.mainContext)
            let categoryDict = dict as! [String: AnyObject]
            category.image_name = categoryDict["image_name"] as? String
            category.title = categoryDict["title"] as? String
        }
        coreDataStack.saveContext()
        UserDefaults.standard.set(true, forKey: "categoriesLoaded")
    }
    
    private func addDefaultCurrencies() {
        if UserDefaults.standard.bool(forKey: "currenciesLoaded") { return }
        
        let path = Bundle.main.path(forResource: "DefaultCurrencies",
                                    ofType: "plist")
        let dataArray = NSArray(contentsOfFile: path!)!
        for dict in dataArray {
            let currency = Currency(context: coreDataStack.mainContext)
            let currencyDict = dict as! [String: AnyObject]
            currency.code = currencyDict["code"] as? String
            currency.name = currencyDict["name"] as? String
            currency.label = currencyDict["label"] as? String
        }
        coreDataStack.saveContext()
        UserDefaults.standard.set(true, forKey: "currenciesLoaded")
    }
    
    private func addDefaultWallets() {
        if UserDefaults.standard.bool(forKey: "walletsLoaded") { return }
        
        let path = Bundle.main.path(forResource: "DefaultWallets",
                                    ofType: "plist")
        let dataArray = NSArray(contentsOfFile: path!)!
        for dict in dataArray {
            let wallet = Wallet(context: coreDataStack.mainContext)
            let walletDict = dict as! [String: AnyObject]
            wallet.name = walletDict["name"] as? String
//            wallet.currency
            // TODO: Link currency
        }
        coreDataStack.saveContext()
        UserDefaults.standard.set(true, forKey: "walletsLoaded")
    }
}

