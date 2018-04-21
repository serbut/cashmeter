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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureChildrenControllers()
        setupNewSpendingButton()
    }
    
    private func configureChildrenControllers() {
        let spendingsNavVC = UINavigationController(rootViewController: createSpendingsVC())

        let stubVC = UIViewController()
        stubVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "coin_icon"), tag: 2)
        
        let walletsVC = createWalletsVC()
        
        viewControllers = [spendingsNavVC, stubVC, walletsVC]
    }
    
    func setupNewSpendingButton() {
        shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 1 {
                return true
            }
            return false
        }
        
        didHijackHandler = { tabbarController, viewController, index in
            let newSpendingVC = self.createNewSpendingVC()
            let newSpendingNavVC = UINavigationController(rootViewController: newSpendingVC)
            self.present(newSpendingNavVC, animated: true, completion: nil)
        }
    }
    
    private func createSpendingsVC() -> UIViewController {
        
        let configurator = SpendingsListModuleConfigurator()
        let module = configurator.buildModule()
        let viewController = module.viewController
        
        viewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "list_icon"), tag: 1)
        return viewController
    }
    
    private func createWalletsVC() -> UIViewController {
        let walletsVC = UIViewController()
        walletsVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "wallet_icon"), tag: 3)
        return walletsVC
    }
    
    private func createNewSpendingVC() -> UIViewController {
        let newSpendingVC = EditSpendingViewController()
        newSpendingVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        
        let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        childContext.parent = coreDataStack.mainContext
        
        newSpendingVC.context = childContext
        newSpendingVC.spendingService = SpendingService(managedObjectContext: childContext, coreDataStack: coreDataStack)
        newSpendingVC.categoryService = CategoryService(managedObjectContext: childContext, coreDataStack: coreDataStack)
        newSpendingVC.delegate = self

        return newSpendingVC
    }
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
