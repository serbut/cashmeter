//
//  CellProtocol.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

protocol TableCellInput: class {
    
    func setup(with cellObject: TableCellObject)
    
}

protocol CollectionCellInput: class {
    
    func setup(with cellObject: CollectionCellObject)
    
}
