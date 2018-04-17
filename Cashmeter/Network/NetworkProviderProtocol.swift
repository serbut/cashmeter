//
//  NetworkProviderProtocol.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 14/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkProviderProtocol: class {
    
    func sendRequest(_ requestType: RequestType, parameters: Parameters?, completion: @escaping () -> Void)
    
}
