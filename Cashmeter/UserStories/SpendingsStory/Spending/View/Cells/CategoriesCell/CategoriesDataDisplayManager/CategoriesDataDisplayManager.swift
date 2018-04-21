//
//  CategoriesDataDisplayManager.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 18/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

final class CategoriesDataDisplayManager: NSObject {
    
    weak var output: CategoriesDataDisplayManagerOutput!
    weak var collectionView: UICollectionView!
    
}

// MARK: CategoriesDataDisplayManagerInput

extension CategoriesDataDisplayManager: CategoriesDataDisplayManagerInput {
    
    func setup(with collectionView: UICollectionView) {
        self.collectionView = collectionView
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func showData(_ cellObjects: [CollectionCellObject]) {
        
    }
    
}

// MARK: UICollectionViewDelegate

extension CategoriesDataDisplayManager: UICollectionViewDelegate {
    
}

// MARK: UICollectionViewDataSource

extension CategoriesDataDisplayManager: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withType: , at: <#T##IndexPath#>, alreadyRegistered: &<#T##Set<String>#>)
        return CategoryCollectionViewCell()
    }
    
}
