//
//  SpendingsListSpendingsListDisplayManager.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 21/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit
import CoreData

final class SpendingsListDisplayManager: NSObject {

    weak var output: SpendingsListDisplayManagerOutput!
    weak var tableView: UITableView!
    var fetchedResultsController: NSFetchedResultsController<Spending>!
    
}

// MARK: SpendingsListDisplayManagerInput

extension SpendingsListDisplayManager: SpendingsListDisplayManagerInput {
    
    func setupInitialState(with tableView: UITableView) {
        self.tableView = tableView
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

// MARK: UITableViewDataSource

extension SpendingsListDisplayManager: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let spending = fetchedResultsController.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withType: SpendingListTableViewCell.self, at: indexPath) as! SpendingListTableViewCell
        
        cell.setup(with: spending)
        
        return cell
    }
    
}

// MARK: UITableViewDelegate

extension SpendingsListDisplayManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let spending = fetchedResultsController.object(at: indexPath)
        output.didSelectSpending(spending: spending)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // TODO: хреново получать spending здесь
            
            let spending = fetchedResultsController.object(at: indexPath)
            output.didTriggerDeleteAction(spending)
        }
    }
    
}

// MARK: NSFetchedResultsControllerDelegate

extension SpendingsListDisplayManager: NSFetchedResultsControllerDelegate {

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
}
