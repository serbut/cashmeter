//
//  SpendingsListSpendingsListDisplayManagerInput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 21/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

protocol SpendingsListDisplayManagerInput: class {

    /**
     Метод настраивает dataDisplayManager.
     
     @param tableView - таблица.
     */
    func setupInitialState(with tableView: UITableView)
    
}
