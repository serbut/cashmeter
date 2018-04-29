//
//  CategoryCollectionViewCell.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 17/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell, HasNib {

    private let normalTintColor: UIColor = .blue
    private let highlightedTintColor: UIColor = .red
    
    @IBOutlet weak var categoryImageView: UIImageView! {
        didSet {
            categoryImageView.tintColor = normalTintColor
        }
    }
    @IBOutlet weak var categoryTitleLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            categoryImageView.tintColor = isSelected ? highlightedTintColor : normalTintColor
            setNeedsDisplay()
        }
    }
    
}
