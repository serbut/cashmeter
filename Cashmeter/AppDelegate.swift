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
        
        InitialDataFillerService().addInitialData()

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

}

