//
//  CategoriesTableViewCell.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 17/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

protocol CategoriesTableViewCellDelegate: class {
    
    /**
     Метод сообщает о том, что была выбрана категория.
     
     @param category - выбранная категория.
     */
    func didSelectCategory(_ category: Category?)
    
}

final class CategoriesTableViewCell: UITableViewCell, HasNib {

    weak var delegate: CategoriesTableViewCellDelegate!
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    var categories: [Category]!
    var alreadyRegisteredCells: Set<String> = []
    var selectedCategoryIndex: IndexPath?
    
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
        if let selectedCategoryIndex = selectedCategoryIndex {
            collectionView.deselectItem(at: selectedCategoryIndex, animated: true)
        }
        
        if (indexPath != selectedCategoryIndex) {
            selectedCategoryIndex = indexPath
            delegate.didSelectCategory(categories[indexPath.row])
        } else {
            selectedCategoryIndex = nil
            delegate.didSelectCategory(nil)
        }
    }
    
}
