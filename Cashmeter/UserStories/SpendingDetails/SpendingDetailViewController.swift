//
//  SpendingDetailViewController.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 29/01/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

class SpendingDetailViewController: UIViewController {
    
    // MARK: Properties
    var spending: Spending!

    // MARK: IBOutlets
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        amountLabel.text = "\(spending.amount) ₽"
        dateLabel.text = stringForDate()
        if spending.details != "" {
            descriptionTextView.text = spending.details 
        }
    }

    func stringForDate() -> String {
        guard let date = spending.date else { return "" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }

}
