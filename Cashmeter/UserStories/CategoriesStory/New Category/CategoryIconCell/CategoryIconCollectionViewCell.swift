//
//  CategoryIconCollectionViewCell.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 03/05/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

class CategoryIconCollectionViewCell: UICollectionViewCell, HasNib {

    private let normalTintColor: UIColor = .blue
    private let highlightedTintColor: UIColor = .red
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.tintColor = normalTintColor
        }
    }

    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? highlightedTintColor : normalTintColor
            setNeedsDisplay()
        }
    }
    
}
