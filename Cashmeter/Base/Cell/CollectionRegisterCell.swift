//
//  CollectionRegisterCell.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 18/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func dequeueReusableCell(withType type: UICollectionViewCell.Type, at indexPath: IndexPath, alreadyRegistered:inout Set<String>) -> UICollectionViewCell {
        if !alreadyRegistered.contains(type.name()) {
            alreadyRegistered.insert(type.name())
            self.register(cell: type)
        }
        
        let cell = self.dequeueReusableCell(withReuseIdentifier: type.name(), for: indexPath)
        
        return cell
    }
    
    private func register(cell type: UICollectionViewCell.Type) {
        let identifier: String = type.name()
        
        if let nibOwner = type as? HasNib.Type {
            let nib: UINib = UINib(nibName: nibOwner.nibName, bundle: nil)
            
            self.register(nib, forCellWithReuseIdentifier: identifier)
        } else {
            self.register(type, forCellWithReuseIdentifier: identifier)
        }
    }
    
}
