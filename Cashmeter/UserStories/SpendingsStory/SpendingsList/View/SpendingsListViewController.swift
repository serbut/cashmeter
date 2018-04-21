//
//  SpendingsListSpendingsListViewController.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 21/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

final class SpendingsListViewController: UIViewController {

    var output: SpendingsListViewOutput!
    var displayManager: SpendingsListDisplayManager!
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddSpendingButton))
        
        output.viewDidLoad()
    }

    @objc func didTapAddSpendingButton() {
        output.didTapAddSpendingButton()
    }
    
}

// MARK: SpendingsListViewInput
  
extension SpendingsListViewController: SpendingsListViewInput {
	
	func setupInitialState() {
		displayManager.setupInitialState(with: tableView)
    }

    func show(cellObjects: [TableCellObject]) {
        displayManager.show(cellObjects: cellObjects)
    }
    
    func reload() {
        tableView.reloadData()
    }

}

// MARK: SpendingsListDisplayManagerOutput

extension SpendingsListViewController: SpendingsListDisplayManagerOutput {
    
    func requestSectionsCount() -> Int {
        return output.requestSectionsCount()
    }
    
    func requestRowsCount(in section: Int) -> Int {
        return output.requestRowsCount(in: section)
    }
    
    func requestCellObject(at indexPath: IndexPath) -> TableCellObject {
        return output.requestCellObject(at: indexPath)
    }
    
}
