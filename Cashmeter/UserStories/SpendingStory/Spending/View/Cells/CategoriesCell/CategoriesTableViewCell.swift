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
    
    @IBOutlet var containerView: UIView!
    fileprivate lazy var categorySelectView = SelectCategory.loadNib()

}

// MARK: TableCellInput

extension CategoriesTableViewCell: TableCellInput {
    
    func setup(with cellObject: TableCellObject) {
        guard let cellObject = cellObject as? CategoriesTableViewCellObject else { return }
        categorySelectView.setup(with: cellObject.categories, selectedCategory: cellObject.selectedCategory)
        categorySelectView.moduleOutput = self
        containerView.addSubview(categorySelectView)
        categorySelectView.translatesAutoresizingMaskIntoConstraints = false
        categorySelectView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        categorySelectView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        categorySelectView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        categorySelectView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
    
}

// MARK: CategorySelectModuleOutput

extension CategoriesTableViewCell: SelectCategoryModuleOutput {
    
    func didSelectCategory(_ category: Category?) {
        delegate.didSelectCategory(category)
    }
    
    func didTapAddCategory() {
        delegate.didTapAddCategory()
    }
    
}
