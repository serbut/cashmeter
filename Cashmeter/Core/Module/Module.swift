//
//  Module.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

protocol Module {
    
    var viewController: UIViewController { get set }
    var moduleInput: AnyObject { get set }
    
}
