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
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var coreDataStack = CoreDataStack(modelName: "Cashmeter")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        _ = coreDataStack.mainContext
        
        InitialDataFillerService().addInitialData()
        
        setupAppearance()

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
    
    private func setupAppearance() {
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = UIColor(red: 32/255, green: 146/255, blue: 202/255, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UINavigationBar.appearance().tintColor = .white
        
        UITabBar.appearance().barTintColor = UIColor(red: 32/255, green: 146/255, blue: 202/255, alpha: 1.0)
        UITabBar.appearance().tintColor = .red
        UITabBar.appearance().unselectedItemTintColor = .white
    }

}

