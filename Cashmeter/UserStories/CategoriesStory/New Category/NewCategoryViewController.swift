//
//  NewCategoryViewController.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 03/05/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

class NewCategoryViewController: UIViewController {

    let vcTitle = "Новая категория"
    
    let iconsImageNames = [
        "car",
        "food",
        "restaurants",
        "transport",
        "travel"
    ]
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var iconsCollectionView: UICollectionView!
    
    var alreadyRegisteredCells: Set<String> = []
    var selectedCategoryIndex: Int?

    var categoryService = ServicesAssembly().categoryService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = vcTitle
        
        iconsCollectionView.dataSource = self
        iconsCollectionView.delegate = self
        setupSaveButton()
        setupCloseButton()
    }
    
    fileprivate func setupSaveButton() {
        let saveBarButton = UIBarButtonItem(image: UIImage(named: "check_bar_button"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(didTapOnSave))
        
        navigationItem.rightBarButtonItem = saveBarButton
    }
    
    @objc func didTapOnSave() {
        guard let title = titleTextField.text else {
            return
            // TODO: Add alert
        }
        guard let iconIndex = selectedCategoryIndex else {
            return
            // TODO: Add alert
        }
        let iconImageName = iconsImageNames[iconIndex]
        categoryService.addCategory(withTitle: title, image_name: iconImageName)
        
        // TODO: Move dismiss to completion
        // TODO: Refresh categories on spending page
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupCloseButton() {
        let closeBarButton = UIBarButtonItem(image: UIImage(named: "close_bar_button"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapOnClose))
        
        navigationItem.leftBarButtonItem = closeBarButton
    }
    
    @objc func didTapOnClose() {
        dismiss(animated: true, completion: nil)
    }
    
    // TODO: Handle keyboard
    // TODO: Rewrite using VIPER
    
}

// MARK: UICollectionViewDataSource

extension NewCategoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconsImageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withType: CategoryIconCollectionViewCell.self, at: indexPath, alreadyRegistered: &alreadyRegisteredCells) as! CategoryIconCollectionViewCell
        
        let imageName = iconsImageNames[indexPath.row]
        cell.imageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        
        return cell
    }
    
}

// MARK: UICollectionViewDelegate

extension NewCategoryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategoryIndex = indexPath.row
    }
    
}
