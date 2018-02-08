//
//  MainTabBarViewController.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 08/02/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import CoreData

class MainTabBarViewController: ESTabBarController {

    var coreDataStack: CoreDataStack!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let spendingsVC = storyboard.instantiateViewController(withIdentifier: "All Spendings") as! SpendingsTableViewController
        spendingsVC.coreDataStack = coreDataStack
        spendingsVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "list_icon"), tag: 1)
        let spendingsNavVC = UINavigationController(rootViewController: spendingsVC)
        
        let stubVC = UIViewController()
        stubVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "coin_icon"), tag: 2)
        
        let walletsVC = storyboard.instantiateViewController(withIdentifier: "Wallets")
        walletsVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "wallet_icon"), tag: 3)
        
        viewControllers = [spendingsNavVC, stubVC, walletsVC]
        
        shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 1 {
                return true
            }
            return false
        }
        
        didHijackHandler = { tabbarController, viewController, index in
            let newSpendingVC = storyboard.instantiateViewController(withIdentifier: "New Spending") as! EditSpendingViewController
            newSpendingVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
            
            let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            childContext.parent = self.coreDataStack.mainContext
            
            newSpendingVC.context = childContext
            newSpendingVC.spendingService = SpendingService(managedObjectContext: childContext, coreDataStack: self.coreDataStack)
            newSpendingVC.categoryService = CategoryService(managedObjectContext: childContext, coreDataStack: self.coreDataStack)
            newSpendingVC.delegate = self
            
            let newSpendingNavVC = UINavigationController(rootViewController: newSpendingVC)
            self.present(newSpendingNavVC, animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}

extension MainTabBarViewController: EditSpendingDelegate {
    func didFinish(viewController: EditSpendingViewController, didSave: Bool) {
        guard didSave,
            let context = viewController.context,
            context.hasChanges else {
                dismiss(animated: true)
                return
        }
        
        context.perform {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Error: \(error.localizedDescription)")
            }
            
            self.coreDataStack.saveContext()
        }
        
        dismiss(animated: true)
    }
}
