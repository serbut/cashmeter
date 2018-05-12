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
    
    /**
     Метод сообщает о том, что пользователь нажал на ячейку добавления категории.
     */
    func didTapAddCategory()
    
}

final class CategoriesTableViewCell: UITableViewCell, HasNib {

    weak var delegate: CategoriesTableViewCellDelegate!
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    var categories: [Category]!
    var alreadyRegisteredCells: Set<String> = []
    var selectedCategoryIndex: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        categoriesCollectionView.allowsMultipleSelection = true
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
    }
    
}

// MARK: TableCellInput

extension CategoriesTableViewCell: TableCellInput {
    
    func setup(with cellObject: TableCellObject) {
        guard let cellObject = cellObject as? CategoriesTableViewCellObject else { return }
        categories = cellObject.categories
        categoriesCollectionView.reloadData()
        if let selectedCategory = cellObject.selectedCategory,
            let categoryIndex = categories.index(of: selectedCategory) {
            selectedCategoryIndex = IndexPath(row: categoryIndex, section: 0)
            categoriesCollectionView.selectItem(at: selectedCategoryIndex, animated: true, scrollPosition: .centeredHorizontally)
            categoriesCollectionView.scrollToItem(at: selectedCategoryIndex!, at: .centeredHorizontally, animated: false)
        }
    }
    
}

// MARK: UICollectionViewDataSource

extension CategoriesTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < categories.count {
            let cell = collectionView.dequeueReusableCell(withType: CategoryCollectionViewCell.self, at: indexPath, alreadyRegistered: &alreadyRegisteredCells) as! CategoryCollectionViewCell
            cell.categoryTitleLabel.text = categories[indexPath.row].title
            if let imageName = categories[indexPath.row].image_name,
                let image = UIImage(named: imageName) {
                cell.categoryImageView.image = image.withRenderingMode(.alwaysTemplate)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withType: AddCategoryCollectionViewCell.self, at: indexPath, alreadyRegistered: &alreadyRegisteredCells) as! AddCategoryCollectionViewCell
            return cell
        }
    }
    
}

// MARK: UICollectionViewDelegate

extension CategoriesTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < categories.count {
            /* Если уже была выбрана категория - снимаем выделение */
            if let selectedCategoryIndex = selectedCategoryIndex {
                collectionView.deselectItem(at: selectedCategoryIndex, animated: true)
            }
            selectedCategoryIndex = indexPath
            delegate.didSelectCategory(categories[indexPath.row])
        } else {
            delegate.didTapAddCategory()
         }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if indexPath.row < categories.count {
            selectedCategoryIndex = nil
            delegate.didSelectCategory(nil)
        }
    }
    
}
