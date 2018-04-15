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
        
        if let cellObject = cellObjects[indexPath.row] as? ReceiptTableViewCell {
            print("ReceiptTableViewCell tapped")
        }
    }
    
}

extension SpendingDataDisplayManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellClass: UITableViewCell.Type = cellObjects[indexPath.row].cellClass
        let cell = tableView.dequeueReusableCell(withType: cellClass, at: indexPath) as! TableCellInput
        
        cell.setup(with: cellObjects[indexPath.row])
        
        return cell as! UITableViewCell
    }
    
}
