//
//  FilterViewController.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 05/05/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    // TODO: Rewrite with table using VIPER
    
    @IBOutlet weak var fromDateTextField: UITextField!
    @IBOutlet weak var toDateTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var categoriesTableView: UITableView!
    var activeDateTextField: UITextField? {
        willSet {
            fromDateTextField.backgroundColor = .white
            toDateTextField.backgroundColor = .white
        }
        didSet {
            activeDateTextField?.backgroundColor = .lightGraySemiTransparent
        }
    }
    
    var categories: [Category]!
    var selectedCategories: Set<Category> = []
    var moduleOutput: FilterModuleOutput!
    var filter: Filter = Filter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoriesTableView.dataSource = self
        categoriesTableView.delegate = self
        
        fromDateTextField.delegate = self
        toDateTextField.delegate = self
        
        setupSaveButton()
        setupCloseButton()
        activeDateTextField = fromDateTextField
    }

    fileprivate func setupSaveButton() {
        let saveBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "check_bar_button"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(didTapOnSave))
        
        navigationItem.rightBarButtonItem = saveBarButton
    }
    
    @objc func didTapOnSave() {
        filter.categories = Array(selectedCategories)
        moduleOutput.didSelectFilter(filter: filter)
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupCloseButton() {
        let closeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "close_bar_button"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapOnClose))
        
        navigationItem.leftBarButtonItem = closeBarButton
    }
    
    @objc func didTapOnClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        if activeDateTextField == fromDateTextField {
            filter.fromDate = sender.date
        } else if activeDateTextField == toDateTextField {
            filter.toDate = sender.date
        }
        activeDateTextField?.text = sender.date.shortDateFormat
    }
    
}

// MARK: UITableViewDataSource

extension FilterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: FilterCategoryTableViewCell.self, at: indexPath) as! FilterCategoryTableViewCell
        
        let imageName = categories[indexPath.row].image_name ?? "undefined_category"
        cell.iconImageView.image = UIImage(named: imageName)
        cell.titleLabel.text = categories[indexPath.row].title
        
        return cell
    }
    
}

// MARK: UITableViewDelegate

extension FilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategories.insert(categories[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedCategories.remove(categories[indexPath.row])
    }
    
}

// MARK: UITextFieldDelegate

extension FilterViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // TODO: дичь, переделать
        if textField == fromDateTextField || textField == toDateTextField {
            activeDateTextField = textField
            return false
        }
        return true
    }
    
}
