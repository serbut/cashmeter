//
//  FilterModuleOutput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 13/05/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation

protocol FilterModuleOutput {
    
    /**
     Метод сообщает о том, что были выбраны параметры фильтра.
     */
    func didSelectFilter(filter: Filter)
    
}
