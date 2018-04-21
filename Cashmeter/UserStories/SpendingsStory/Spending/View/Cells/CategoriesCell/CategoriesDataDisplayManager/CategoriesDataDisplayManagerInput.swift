//
//  CategoriesDataDisplayManagerInput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 18/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

protocol CategoriesDataDisplayManagerInput: class {
    
    func setup(with collectionView: UICollectionView)
    func showData(_ cellObjects: [CollectionCellObject])
    
}
