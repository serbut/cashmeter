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
    
    var managedContext: NSManagedObjectContext!

    private var categories = [Category]()
    private var spendings = [Spending]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchSpendings()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "NewSpendingSegue":
            let vc = segue.destination as! NewSpendingViewController
            vc.categories = categories
            vc.managedContext = managedContext
        default:
            fatalError("Unexpected segue")
        }
    }
}

// MARK: - Table view data source

extension SpendingsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spendings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpendingCell", for: indexPath) as! SpendingTableViewCell
        let spendingForCell = spendings[indexPath.row]
        
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

// MARK: - Saving and fetching data

extension SpendingsTableViewController {
    private func fetchSpendings() {
        let fetchRequest: NSFetchRequest<Spending> = Spending.fetchRequest()
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            self.spendings = results.reversed()
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        tableView.reloadData()
    }
    
    private func fetchCategories() {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            let results = try managedContext.fetch(fetchRequest)
            if results.count > 0 {
                categories = results
            } else {
                addDefaultCategories()
            }
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
    
    private func addDefaultCategories() {
        let path = Bundle.main.path(forResource: "DefaultCategories",
                                    ofType: "plist")
        let dataArray = NSArray(contentsOfFile: path!)!
        for dict in dataArray {
            let category = Category(context: managedContext)
            let catDict = dict as! [String: AnyObject]
            category.icon = catDict["icon"] as? String
            category.title = catDict["title"] as? String
            categories.append(category)
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Save error: \(error), description: \(error.userInfo)")
        }
    }
}
