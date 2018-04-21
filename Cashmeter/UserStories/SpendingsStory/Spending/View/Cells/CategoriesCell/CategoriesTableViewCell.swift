//
//  CategoriesTableViewCell.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 17/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

final class CategoriesTableViewCell: UITableViewCell, HasNib {

    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    var categories: [Category]!
    var alreadyRegisteredCells: Set<String> = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
    }
    
}

// MARK: TableCellInput

extension CategoriesTableViewCell: TableCellInput {
    
    func setup(with cellObject: TableCellObject) {
        guard let cellObject = cellObject as? CategoriesTableViewCellObject else { return }
        categories = cellObject.categories
    }
    
}

// MARK: UICollectionViewDataSource

extension CategoriesTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withType: CategoryCollectionViewCell.self, at: indexPath, alreadyRegistered: &alreadyRegisteredCells) as! CategoryCollectionViewCell

        cell.categoryTitleLabel.text = categories[indexPath.row].title
        if let imageName = categories[indexPath.row].image_name {
            cell.categoryImageView.image = UIImage(named: imageName)
        }

        return cell
    }
    
}

// MARK: UICollectionViewDelegate

extension CategoriesTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
        cell.backgroundColor = .blue
    }
    
}
