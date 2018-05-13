//
//  CategorySelectModuleOutput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 13/05/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

protocol SelectCategoryModuleOutput: class {
    
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
