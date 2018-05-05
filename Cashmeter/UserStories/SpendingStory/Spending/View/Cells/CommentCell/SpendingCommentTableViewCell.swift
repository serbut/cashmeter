//
//  SpendingCommentTableViewCell.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 05/05/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

protocol SpendingCommentTableViewCellDelegate: class {
    
    /**
     Метод сообщает о том, что комментарий был изменен.
     */
    func didChangeComment(_ comment: String?)
    
}

final class SpendingCommentTableViewCell: UITableViewCell, HasNib {

    weak var delegate: SpendingCommentTableViewCellDelegate!
    
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBAction func didChangeComment(_ sender: UITextField) {
        delegate.didChangeComment(sender.text)
    }
    
}

// MARK: TableCellInput

extension SpendingCommentTableViewCell: TableCellInput {
    
    func setup(with cellObject: TableCellObject) {
        guard let cellObject = cellObject as? SpendingCommentTableViewCellObject else { return }
        
        commentTextField.text = cellObject.commentText
    }
    
}
