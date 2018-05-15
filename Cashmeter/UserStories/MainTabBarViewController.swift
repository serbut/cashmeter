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
        
        configureChildrenControllers()
        setupNewSpendingButton()
    }
    
    private func configureChildrenControllers() {
        let spendingsNavVC = createSpendingsVC()

        let stubVC = UIViewController()
        stubVC.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "coin_icon"), tag: 2)
        
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
            self.present(newSpendingVC, animated: true, completion: nil)
        }
    }
    
    private func createSpendingsVC() -> UIViewController {
        
        let configurator = SpendingsListModuleConfigurator()
        let module = configurator.buildModule()
        let viewController = module.viewController
        
        viewController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "list_icon"), tag: 1)
        return UINavigationController(rootViewController: viewController)
    }
    
    private func createWalletsVC() -> UIViewController {
        let walletsVC = WalletsListViewController()
        walletsVC.walletService = ServicesAssembly().walletService()
        walletsVC.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "wallet_icon"), tag: 3)
        return UINavigationController(rootViewController: walletsVC)
    }
    
    private func createNewSpendingVC() -> UIViewController {
        let configurator = SpendingConfigurator()
        let module = configurator.spendingModule()
        let viewController = module.viewController
        
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        return UINavigationController(rootViewController: viewController)
    }
}
