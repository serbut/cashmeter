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
protocol EditSpendingDelegate {
    func didFinish(viewController: EditSpendingViewController, didSave: Bool)
}

class EditSpendingViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoriesTableView: UITableView!
    
    // MARK: Properties
    var delegate: EditSpendingDelegate?
    var spending: Spending?
    var context: NSManagedObjectContext!
    var spendingService: SpendingService!
    var categoryService: CategoryService!
    
    var categories = [Category]()
    private var selectedCategoryIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriesTableView.dataSource = self
        categoriesTableView.delegate = self
        
        categories = categoryService.getCategories()
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
        let category = categories[selectedCategoryIndex]
        let details = descriptionTextView.text
        
        if let spending = spending {
            spendingService.updateSpending(spending,
                                           withAmount: amount,
                                           category: category,
                                           details: details)
        } else {
            spending = spendingService.addSpending(withAmount: amount,
                                        category: category,
                                        details: details)
        }
        return true
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
