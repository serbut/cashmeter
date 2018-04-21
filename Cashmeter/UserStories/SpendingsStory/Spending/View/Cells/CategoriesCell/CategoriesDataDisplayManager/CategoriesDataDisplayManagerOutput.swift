//
//  CategoriesDataDisplayManagerOutput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 18/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

protocol CategoriesDataDisplayManagerOutput: class {

    /**
     Метод сообщает о том, что пользователь нажал на ячейку с категорией
     */
    func didSelectCategory()
    
}
