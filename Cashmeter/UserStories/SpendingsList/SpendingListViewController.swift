//
//  SpendingListViewController.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 14/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit
import CoreData

class SpendingListViewController: UIViewController {

    var coreDataStack: CoreDataStack!
    var fetchedResultsController: NSFetchedResultsController<Spending>!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SpendingTableViewCell", bundle: nil), forCellReuseIdentifier: "SpendingCell")
        fetchedResultsController = spendingsFetchedResultsController()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSpending))
    }
    
    @objc func addSpending() {
        let newSpendingVC = EditSpendingViewController()
        
        let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        childContext.parent = coreDataStack.mainContext
        
        newSpendingVC.context = childContext
        newSpendingVC.spendingService = SpendingService(managedObjectContext: childContext, coreDataStack: coreDataStack)
        newSpendingVC.categoryService = CategoryService(managedObjectContext: childContext, coreDataStack: coreDataStack)
        newSpendingVC.delegate = self
        
        self.present(UINavigationController(rootViewController: newSpendingVC), animated: true, completion: nil)
    }

}

// MARK: - Table view data source

extension SpendingListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpendingCell", for: indexPath) as! SpendingTableViewCell
        let spendingForCell = fetchedResultsController.object(at: indexPath)
        
//        cell.categoryIconLabel.text = spendingForCell.category?.icon
        cell.categoryNameLabel.text = spendingForCell.category?.title
        cell.amountLabel.text = "\(spendingForCell.amount) ₽"
        
        return cell
    }
}

// MARK: - Table view delegate

extension SpendingListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let spending = fetchedResultsController.object(at: indexPath)
        let configurator = SpendingConfigurator()
        let module = configurator.spendingModule()
        let viewController = module.viewController
        let moduleInput = module.moduleInput as? SpendingModuleInput
        moduleInput?.setup(with: spending)

        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

// MARK: SpendingDelegate

extension SpendingListViewController: EditSpendingDelegate {
    
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

// MARK: NSFetchedResultsController

extension SpendingListViewController: NSFetchedResultsControllerDelegate {
    
    func spendingsFetchedResultsController() -> NSFetchedResultsController<Spending> {
        let fetchedResultController = NSFetchedResultsController(fetchRequest: spendingsFetchRequest(),
                                                                 managedObjectContext: coreDataStack.mainContext,
                                                                 sectionNameKeyPath: nil,
                                                                 cacheName: nil)
        fetchedResultController.delegate = self
        
        do {
            try fetchedResultController.performFetch()
        } catch let error as NSError {
            fatalError("Error: \(error.localizedDescription)")
        }
        
        return fetchedResultController
    }
    
    func spendingsFetchRequest() -> NSFetchRequest<Spending> {
        let fetchRequest: NSFetchRequest<Spending> = Spending.fetchRequest()
        fetchRequest.fetchBatchSize = 20
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
}
