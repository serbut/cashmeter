//
//  NewSpendingViewController.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 08/01/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit
import CoreData

// MARK: SpendingDelegate
protocol SpendingDelegate {
    func didFinish(viewController: EditSpendingViewController, didSave: Bool)
}

class EditSpendingViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoriesTableView: UITableView!
    
    // MARK: Properties
    var delegate: SpendingDelegate?
    var context: NSManagedObjectContext!
    var spending: Spending!
    
    var categories = [Category]()
    private var selectedCategoryIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriesTableView.dataSource = self
        categoriesTableView.delegate = self
        
        fetchCategories()
    }
    
    // MARK: IBActions
    @IBAction func saveButtonPushed(_ sender: UIBarButtonItem) {
        if updateSpendingEntry() {
            delegate?.didFinish(viewController: self, didSave: true)
        } else {
            // TODO: Show alert
        }
    }
    
    @IBAction func cancelButtonPushed(_ sender: UIBarButtonItem) {
        delegate?.didFinish(viewController: self, didSave: false)
    }
    
    func updateSpendingEntry() -> Bool{
        guard let amount = Double(amountTextField.text!) else { return false }
        spending.amount = amount
        spending.category = categories[selectedCategoryIndex]
        spending.details = descriptionTextView.text
        spending.date = Date()
        return true
    }
    
    // TODO: Move this function
    private func fetchCategories() {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                categories = results
            }
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
    }
    
}

extension EditSpendingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        let categoryForCell = categories[indexPath.row]
        
        cell.iconLabel.text = categoryForCell.icon
        cell.titleLabel.text = categoryForCell.title
        if selectedCategoryIndex == indexPath.row {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    
        return cell
    }
}

extension EditSpendingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategoryIndex = indexPath.row
        tableView.reloadData()
    }
}
