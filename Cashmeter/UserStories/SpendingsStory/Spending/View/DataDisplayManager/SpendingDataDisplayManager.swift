//
//  SpendingDataDisplayManager.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

final class SpendingDataDisplayManager: NSObject {
    
    weak var output: SpendingDataDisplayManagerOutput!
    weak var tableView: UITableView!
    var cellObjects: [TableCellObject] = []
    
}

// MARK: SpendingDataDisplayManagerInput

extension SpendingDataDisplayManager: SpendingDataDisplayManagerInput {
    
    func setup(with tableView: UITableView) {
        self.tableView = tableView
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func showData(_ cellObjects: [TableCellObject]) {
        self.cellObjects = cellObjects
        tableView.reloadData()
    }
    
}

// MARK: UITableViewDelegate

extension SpendingDataDisplayManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let _ = cellObjects[indexPath.row] as? AddReceiptTableViewCellObject {
            output.didTriggerScanQrAction()
        }
        else if let cell = tableView.cellForRow(at: indexPath) as? SpendingDateTableViewCell {
            let datePicker = cell.datePicker!
            datePicker.isHidden = !datePicker.isHidden
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.tableView.beginUpdates()
                datePicker.alpha = datePicker.isHidden ? 0.0 : 1.0
                self.tableView.deselectRow(at: indexPath, animated: true)
                self.tableView.endUpdates()
            })
        }
        else if let _ = cellObjects[indexPath.row] as? SpendingReceiptItemsTableViewCellObject {
            output.didTriggerShowSpendingItemsAction()
        }
    }
    
}

// MARK: UITableViewDataSource

extension SpendingDataDisplayManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellClass: UITableViewCell.Type = cellObjects[indexPath.row].cellClass
        let cell = tableView.dequeueReusableCell(withType: cellClass, at: indexPath) as! TableCellInput
        
        cell.setup(with: cellObjects[indexPath.row])
        
        if let cell = cell as? AmountTableViewCell {
            cell.delegate = self
        }
        else if let cell = cell as? SpendingDateTableViewCell {
            cell.delegate = self
        }
        else if let cell = cell as? CategoriesTableViewCell {
            cell.delegate = self
        }
        
        return cell as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cell = tableView.cellForRow(at: indexPath) as? SpendingDateTableViewCell {
            let height: CGFloat = cell.datePicker.isHidden ? 50 : 212
            return height
        }
        return UITableViewAutomaticDimension
    }
    
}

// MARK: AmountTableViewCellDelegate

extension SpendingDataDisplayManager: AmountTableViewCellDelegate {
    
    func didChangeAmountValue(_ value: String?) {
        output.didChangeAmountValue(value)
    }
    
}

// MARK: SpendingDateTableViewCellDelegate

extension SpendingDataDisplayManager: SpendingDateTableViewCellDelegate {
    
    func didChangeDateValue(_ value: Date?) {
        output.didChangeDateValue(value)
    }
    
}

// MARK: CategoriesTableViewCellDelegate

extension SpendingDataDisplayManager: CategoriesTableViewCellDelegate {
    
    func didSelectCategory(_ category: Category?) {
        output.didSelectCategory(category)
    }
    
    func didTapAddCategory() {
        print("Add category")
    }
    
}
