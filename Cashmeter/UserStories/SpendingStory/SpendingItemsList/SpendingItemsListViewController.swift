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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet var categoriesCollectionViewHeightConstraint: NSLayoutConstraint!
    
    var spendingItems: [SpendingItemInfo]!
    var categories: [Category]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = vcTitle
        // TODO: leftBarButtonItem = nil here
        navigationItem.leftBarButtonItem?.title = leftBarButtonTitle
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupSplitButton()
    }
    
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
    
    private func setupNormalMode() {
        categoriesCollectionViewHeightConstraint.constant = 0.0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        navigationItem.leftBarButtonItem = navigationItem.backBarButtonItem
        setupSplitButton()
    }
    
    private func setupSplitMode() {
        categoriesCollectionViewHeightConstraint.constant = 50.0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        setupCancelSplitButton()
        setupSplitDoneButton()
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
        
        cell.nameLabel.text = itemForCell.name
        cell.priceCountLabel.text = "\(itemForCell.price) * \(itemForCell.quantity)"
        cell.amountLabel.text = "\(itemForCell.amount)"
        
        return cell
    }
    
}

// MARK: UITableViewDelegate

extension SpendingItemsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
