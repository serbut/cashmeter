//
//  FilterViewController.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 05/05/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSaveButton()
        setupCloseButton()
    }

    fileprivate func setupSaveButton() {
        let saveBarButton = UIBarButtonItem(image: UIImage(named: "check_bar_button"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(didTapOnSave))
        
        self.navigationItem.rightBarButtonItem = saveBarButton
    }
    
    @objc func didTapOnSave() {

    }
    
    fileprivate func setupCloseButton() {
        let closeBarButton = UIBarButtonItem(image: UIImage(named: "close_bar_button"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapOnClose))
        
        self.navigationItem.leftBarButtonItem = closeBarButton
    }
    
    @objc func didTapOnClose() {
        dismiss(animated: true, completion: nil)
    }

}
