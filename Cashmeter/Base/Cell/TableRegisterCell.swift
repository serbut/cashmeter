//
//  TableViewExtension.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

extension UITableView {
    
    func dequeueReusableCell(withType type: UITableViewCell.Type, at indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.dequeueReusableCell(withIdentifier: type.name()) {
            return cell
        }
        
        self.register(cell: type)
        let cell = self.dequeueReusableCell(withIdentifier: type.name(), for: indexPath)
        return cell
    }
    
    private func register(cell type: UITableViewCell.Type) {
        let identifier: String = type.name()
        
        if let nibOwner = type as? HasNib.Type {
            let nib: UINib = UINib(nibName: nibOwner.nibName, bundle: nil)
            
            self.register(nib, forCellReuseIdentifier: identifier)
        } else {
            self.register(type, forCellReuseIdentifier: identifier)
        }
    }
    
}
