//
//  CategoryCollectionViewCell.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 17/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell, HasNib {

    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? .blue : .clear
            self.setNeedsDisplay()
        }
    }
    
}

extension CategoryCollectionViewCell: CollectionCellInput {
    
    func setup(with cellObject: CollectionCellObject) {
        guard let cellObject = cellObject as? CategoryCollectionViewCellObject else { return }
        categoryTitleLabel.text = cellObject.category.title
    }
    
}
