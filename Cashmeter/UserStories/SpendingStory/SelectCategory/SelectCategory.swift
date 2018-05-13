//
//  SelectCategory.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 13/05/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

final class SelectCategory: UIView, HasNib {

    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    var alreadyRegisteredCells: Set<String> = []

    var categories: [Category]!
    var selectedCategoryIndex: IndexPath?

    var moduleOutput: SelectCategoryModuleOutput!    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        categoriesCollectionView.allowsMultipleSelection = true
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
    }
    
}

// MARK: SelectCategoryModuleInput

extension SelectCategory: SelectCategoryModuleInput {
    
    func setup(with categories: [Category], selectedCategory: Category?) {
        self.categories = categories
        categoriesCollectionView.reloadData()
        if let selectedCategory = selectedCategory,
            let categoryIndex = categories.index(of: selectedCategory) {
            selectedCategoryIndex = IndexPath(row: categoryIndex, section: 0)
            categoriesCollectionView.selectItem(at: selectedCategoryIndex, animated: true, scrollPosition: .centeredHorizontally)
            categoriesCollectionView.scrollToItem(at: selectedCategoryIndex!, at: .centeredHorizontally, animated: false)
        }
    }
    
}

// MARK: UICollectionViewDataSource

extension SelectCategory: UICollectionViewDataSource {
    
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

extension SelectCategory: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < categories.count {
            /* Если уже была выбрана категория - снимаем выделение */
            if let selectedCategoryIndex = selectedCategoryIndex {
                collectionView.deselectItem(at: selectedCategoryIndex, animated: true)
            }
            selectedCategoryIndex = indexPath
            moduleOutput.didSelectCategory(categories[indexPath.row])
        } else {
            moduleOutput.didTapAddCategory()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if indexPath.row < categories.count {
            selectedCategoryIndex = nil
            moduleOutput.didSelectCategory(nil)
        }
    }
    
}

