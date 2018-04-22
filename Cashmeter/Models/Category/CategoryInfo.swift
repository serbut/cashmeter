//
//  CategoryInfo.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 22/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

final class CategoryInfo {
    
    var title: String
    
    init(from category: Category) {
        self.title = category.title!
    }
    
}
