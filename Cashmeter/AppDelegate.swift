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

        guard let tabController = window?.rootViewController as? MainTabBarViewController else {
                return true
        }
        tabController.coreDataStack = coreDataStack
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
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

