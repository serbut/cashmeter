//
//  SpendingsListSpendingsListDisplayManager.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 21/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

final class SpendingsListDisplayManager: NSObject {

    weak var output: SpendingsListDisplayManagerOutput!
    weak var tableView: UITableView!

    var cellObjects: [TableCellObject] = []

}

// MARK: SpendingsListDisplayManagerInput

extension SpendingsListDisplayManager: SpendingsListDisplayManagerInput {
    
    func setupInitialState(with tableView: UITableView) {
        self.tableView = tableView
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func show(cellObjects: [TableCellObject]) {
        self.cellObjects = cellObjects

        tableView.reloadData()
    }
    
}

// MARK: UITableViewDataSource

extension SpendingsListDisplayManager: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return output.requestSectionsCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(output.requestRowsCount(in: section))
        return output.requestRowsCount(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let object = output.requestCellObject(at: indexPath)
        let cell = tableView.dequeueReusableCell(withType: object.cellClass, at: indexPath) as! TableCellInput
        
        cell.setup(with: object)
        
        return cell as! UITableViewCell
    }
    
}

// MARK: UITableViewDelegate

extension SpendingsListDisplayManager: UITableViewDelegate {
    
}
