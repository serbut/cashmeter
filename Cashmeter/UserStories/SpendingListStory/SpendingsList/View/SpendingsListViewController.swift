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
        
         self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "filter_bar_button"),
                                                                  style: .plain,
                                                                  target: self,
                                                                  action: #selector(didTapFilterButton))
        
        output.viewDidLoad()
    }

    @objc func didTapFilterButton() {
        output.didTapFilterButton()
    }
    
}

// MARK: SpendingsListViewInput
  
extension SpendingsListViewController: SpendingsListViewInput {
	
	func setupInitialState() {
		displayManager.setupInitialState(with: tableView)
    }

    func reload() {
        tableView.reloadData()
    }

}

// MARK: SpendingsListDisplayManagerOutput

extension SpendingsListViewController: SpendingsListDisplayManagerOutput {

    func didSelectSpending(spending: Spending) {
        output.didSelectSpending(spending: spending)
    }
    
    func didTriggerDeleteAction(_ spending: Spending) {
        output.didTriggerDeleteAction(spending)
    }

}
