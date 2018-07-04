//
//  HasNib.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

protocol HasNib: class {
    
    static var nibName: String { get }
    
}

extension HasNib where Self: UIView {
    
    static var nibName: String {
        return Self.name()
    }
    
}

extension UIView {
    
    class func name() -> String {
        return String(describing: self)
    }
    
    class func loadNib(name: String? = nil) -> Self {
        return loadNib(by: name)
    }
    
    private class func loadNib<T>(by name: String?) -> T {
        var viewName: String? = name
        
        if viewName == nil {
            viewName = self.name()
        }
        
        let view: T = UINib(nibName: viewName!, bundle: nil).instantiate(withOwner: nil, options: nil).first as! T
        
        return view
    }
    
}
