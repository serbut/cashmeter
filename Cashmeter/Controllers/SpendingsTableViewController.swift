//
//  SpendingsTableViewController.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 23/01/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit
import CoreData

class SpendingsTableViewController: UITableViewController {
    
    var coreDataStack: CoreDataStack!
    var fetchedResultsController: NSFetchedResultsController<Spending> = NSFetchedResultsController()
    
    private var spendings = [Spending]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultsController = spendingsFetchedResultsController()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "NewSpendingSegue":
            guard let navigationController = segue.destination as? UINavigationController,
                let vc = navigationController.topViewController as? EditSpendingViewController else {
                    fatalError("Application storyboard mis-configuration")
            }
            
            let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            childContext.parent = coreDataStack.mainContext

            vc.context = childContext
            vc.spendingService = SpendingService(managedObjectContext: childContext, coreDataStack: coreDataStack)
            vc.categoryService = CategoryService(managedObjectContext: childContext, coreDataStack: coreDataStack)
            vc.delegate = self
            
        case "SpendingDetailSegue":
            guard let vc = segue.destination as? SpendingDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else {
                    fatalError("Application storyboard mis-configuration")
            }
            
            vc.spending = fetchedResultsController.object(at: indexPath)
            
        default:
            fatalError("Unexpected segue")
        }
    }
}

// MARK: - Table view data source

extension SpendingsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpendingCell", for: indexPath) as! SpendingTableViewCell
        let spendingForCell = fetchedResultsController.object(at: indexPath)
        
        cell.categoryIconLabel.text = spendingForCell.category?.icon
        cell.categoryNameLabel.text = spendingForCell.category?.title
        cell.amountLabel.text = "\(spendingForCell.amount) ₽"
        
        return cell
    }
}

// MARK: - Table view delegate

extension SpendingsTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: SpendingDelegate
extension SpendingsTableViewController : EditSpendingDelegate {
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
extension SpendingsTableViewController : NSFetchedResultsControllerDelegate {
    func spendingsFetchedResultsController() -> NSFetchedResultsController<Spending> {
        let fetchedResultController = NSFetchedResultsController(fetchRequest: surfJournalFetchRequest(),
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
    
    func surfJournalFetchRequest() -> NSFetchRequest<Spending> {
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
