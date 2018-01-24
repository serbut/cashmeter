//
//  NewSpendingViewController.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 08/01/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit
import CoreData

class NewSpendingViewController: UIViewController {
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoriesTableView: UITableView!
    
    var categories: [Category]!
    var managedContext: NSManagedObjectContext!
    private var selectedCategoryIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriesTableView.dataSource = self
        categoriesTableView.delegate = self
    }
    
    @IBAction func saveButtonPushed(_ sender: UIBarButtonItem) {
        if saveSpending() {
            self.navigationController?.popViewController(animated: true)
        } else {
            // TODO: Show alert
        }
    }
    
}

extension NewSpendingViewController: UITableViewDataSource {
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

extension NewSpendingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategoryIndex = indexPath.row
        tableView.reloadData()
    }
}

extension NewSpendingViewController {
    private func saveSpending() -> Bool {
        guard let amount = Double(amountTextField.text!) else { return false }
        let newSpending = Spending(context: managedContext)
        newSpending.amount = amount
        newSpending.category = categories[selectedCategoryIndex]
        newSpending.details = descriptionTextView.text
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Save error: \(error), description: \(error.userInfo)")
            return false
        }
        return true
    }
}
