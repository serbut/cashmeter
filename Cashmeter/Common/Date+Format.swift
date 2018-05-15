//
//  Date+Format.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 12/05/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation

extension Date {
    
    var shortFormat: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
            return dateFormatter.string(from: self)
        }
    }
    
    var shortDateFormat: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            return dateFormatter.string(from: self)
        }
    }
    
    init?(fromQrString string: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd'T'HHmmss"
        guard let date = dateFormatter.date(from: string) else {
            return nil
        }
        self = date
    }
    
}
