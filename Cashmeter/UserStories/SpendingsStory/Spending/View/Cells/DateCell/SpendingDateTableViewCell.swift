//
//  SpendingDateTableViewCell.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 21/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

final class SpendingDateTableViewCell: UITableViewCell, HasNib {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        dateLabel.text = datePicker.date.description
    }
}

extension SpendingDateTableViewCell: TableCellInput {
    
    func setup(with cellObject: TableCellObject) {
        guard let cellObject = cellObject as? SpendingDateTableViewCellObject else { return }
        
        dateLabel.text = cellObject.date.description
        datePicker.date = cellObject.date
    }
    
}
