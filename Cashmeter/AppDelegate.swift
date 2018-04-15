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
        self.addDefaultCategories()

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
            let catDict = dict as! [String: AnyObject]
            category.icon = catDict["icon"] as? String
            category.title = catDict["title"] as? String
        }
        coreDataStack.saveContext()
        UserDefaults.standard.set(true, forKey: "categoriesLoaded")
    }
}

