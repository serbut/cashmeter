//
//  SpendingItemsListViewController.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 23/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

class SpendingItemsListViewController: UIViewController {

    let vcTitle = "Список позиций"
    let leftBarButtonTitle = "Назад"
    let splitTitle = "Разделить" // TODO: Think about naming
    let cancelSplitTitle = "Отменить"
    
    var splitModeEnabled = false
    let categoriesOpenHeightConstraintValue: CGFloat = 120.0
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var categoriesContainerView: UIView!
    @IBOutlet var categoriesContainerViewHeightConstraint: NSLayoutConstraint!
    fileprivate lazy var categorySelectView = SelectCategory.loadNib()
    
    var spendingItems: [SpendingItemInfo]!
    var categoryService: CategoryService!
    var selectedItems: [SpendingItemInfo] = []
    var moduleOutput: SpendingItemsListModuleOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = vcTitle
        // TODO: leftBarButtonItem = nil here
        navigationItem.leftBarButtonItem?.title = leftBarButtonTitle
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupCategoriesView()
        setupSplitButton()
        
        // TODO: Setup mode, nor button
    }
    
    func setupCategoriesView() {
        let categories = categoryService.getCategories()
        categorySelectView.setup(with: categories, selectedCategory: nil)
        categorySelectView.moduleOutput = self
        categoriesContainerView.addSubview(categorySelectView)
        categorySelectView.translatesAutoresizingMaskIntoConstraints = false
        categorySelectView.leadingAnchor.constraint(equalTo: categoriesContainerView.leadingAnchor).isActive = true
        categorySelectView.trailingAnchor.constraint(equalTo: categoriesContainerView.trailingAnchor).isActive = true
        categorySelectView.topAnchor.constraint(equalTo: categoriesContainerView.topAnchor).isActive = true
        categorySelectView.bottomAnchor.constraint(equalTo: categoriesContainerView.bottomAnchor).isActive = true
    }
    
    private func setupNormalMode() {
        splitModeEnabled = false
        categoriesContainerViewHeightConstraint.constant = 0.0
        UIView.animate(withDuration: 0.5) {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
        navigationItem.leftBarButtonItem = navigationItem.backBarButtonItem
        setupSplitButton()
        tableView.allowsSelection = false
    }
    
    private func setupSplitMode() {
        splitModeEnabled = true
        categoriesContainerViewHeightConstraint.constant = categoriesOpenHeightConstraintValue
        UIView.animate(withDuration: 0.5) {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
        setupCancelSplitButton()
        setupSplitDoneButton()
        tableView.allowsMultipleSelection = true
    }
    
}

// MARK: Buttons

extension SpendingItemsListViewController {
    
    fileprivate func setupSplitButton() {
        let splitBarButton = UIBarButtonItem(title: splitTitle,
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapOnSplit))
        
        navigationItem.rightBarButtonItem = splitBarButton
    }
    
    @objc func didTapOnSplit() {
        setupSplitMode()
    }
    
    fileprivate func setupSplitDoneButton() {
        let splitDoneButton = UIBarButtonItem(image: #imageLiteral(resourceName: "check_bar_button"),
                                              style: .plain,
                                              target: self,
                                              action: #selector(didTapOnSplitDone))
        
        navigationItem.rightBarButtonItem = splitDoneButton
    }
    
    @objc func didTapOnSplitDone() {
        moduleOutput.didSplitItems(spendingItems)
        setupNormalMode()
    }
    
    fileprivate func setupCancelSplitButton() {
        let cancelSplitButton = UIBarButtonItem(image: #imageLiteral(resourceName: "close_bar_button"),
                                                style: .plain,
                                                target: self,
                                                action: #selector(didTapOnCancelSplit))
        
        navigationItem.leftBarButtonItem = cancelSplitButton
    }
    
    @objc func didTapOnCancelSplit() {
        setupNormalMode()
    }
    
}

// MARK: UITableViewDataSource

extension SpendingItemsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spendingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: SpendingItemTableViewCell.self, at: indexPath) as! SpendingItemTableViewCell
        let itemForCell = spendingItems[indexPath.row]
        
        cell.nameTextView.text = itemForCell.name
        cell.priceCountLabel.text = "\(itemForCell.price) * \(itemForCell.quantity)"
        cell.amountLabel.text = "\(itemForCell.amount)"
        cell.categoryContainer.isHidden = itemForCell.category == nil
        cell.categoryTitleLabel.text = itemForCell.category?.title
        let imageName = itemForCell.category?.image_name ?? "undefined_category"
        cell.categoryImageView.image = UIImage(named: imageName)
        
        return cell
    }
    
}

// MARK: UITableViewDelegate

extension SpendingItemsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard splitModeEnabled else { return }
        let item = spendingItems[indexPath.row]
        if selectedItems.contains(item),
            let index = spendingItems.index(of: item) {
            tableView.deselectRow(at: indexPath, animated: true)
            spendingItems.remove(at: index)
        } else {
            selectedItems.append(item)
        }
    }
    
}

// MARK: SelectCategoryModuleOutput

extension SpendingItemsListViewController: SelectCategoryModuleOutput {
    
    func didSelectCategory(_ category: Category?) {
        selectedItems.forEach { $0.category = category }
        selectedItems = []
        categorySelectView.deselectSelectedCategory()
        tableView.reloadData()
    }
    
    func didTapAddCategory() {
        let viewContoller = NewCategoryViewController()
        viewContoller.moduleOutput = self
        viewContoller.categoryService = ServicesAssembly().categoryService()
        let navVC = UINavigationController(rootViewController: viewContoller)
        
        present(navVC, animated: true, completion: nil)
    }
    
}

// MARK: NewCategoryModuleOutput

extension SpendingItemsListViewController: NewCategoryModuleOutput {
    
    func didAddCategory() {
        setupCategoriesView()
    }
    
}
