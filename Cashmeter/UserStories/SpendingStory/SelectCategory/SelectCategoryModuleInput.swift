//
//  SelectCategoryModuleInput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 13/05/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

protocol SelectCategoryModuleInput {
    
    /**
     Метод настраивает модуль со списком категорий.
     
     @param categories - список категорий.
     
     @param selectedCategory - выбранная категория.
     */
    func setup(with categories: [Category], selectedCategory: Category?)
    
}
