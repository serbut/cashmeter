//
//  NewCategoryViewController.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 03/05/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

class NewCategoryViewController: UIViewController {

    var moduleOutput: NewCategoryModuleOutput!
    let vcTitle = "Новая категория"
    let fillTitleError = "Введите название категории"
    let chooseIconError = "Выберите иконку для категории"
    
    let iconsImageNames = [
        "food",
        "restaurants",
        "beer",
        "beer_bottle",
        "transport",
        "travel",
        "baby",
        "children",
        "student_male",
        "carousel",
        "gift",
        "car",
        "dirt_bike",
        "kart",
        "service",
        "guitar",
        "musical_notes",
        "party_baloon",
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
        
        hideKeyboardWhenTappedAround() 
    }
    
    fileprivate func setupSaveButton() {
        let saveBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "check_bar_button"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(didTapOnSave))
        
        navigationItem.rightBarButtonItem = saveBarButton
    }
    
    @objc func didTapOnSave() {
        guard let title = titleTextField.text, !title.isEmpty else {
            // TODO: Check not consists of spaces
            showAlert(with: fillTitleError)
            return
        }
        guard let iconIndex = selectedCategoryIndex else {
            showAlert(with: chooseIconError)
            return
        }
        let iconImageName = iconsImageNames[iconIndex]
        categoryService.addCategory(withTitle: title, imageName: iconImageName)
        
        // TODO: Move dismiss to completion
        moduleOutput.didAddCategory()
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupCloseButton() {
        let closeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "close_bar_button"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapOnClose))
        
        navigationItem.leftBarButtonItem = closeBarButton
    }
    
    @objc func didTapOnClose() {
        dismiss(animated: true, completion: nil)
    }
    
    func showAlert(with message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: SpendingConstants.closeActionTitle, style: .cancel, handler: nil)
        alert.addAction(closeAction)
        present(alert, animated: true, completion: nil)
    }
    
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
