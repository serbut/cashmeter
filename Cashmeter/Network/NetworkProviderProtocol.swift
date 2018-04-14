//
//  NetworkProviderProtocol.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 14/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation

protocol NetworkProviderProtocol: class {
    
    func sendRequest(_ requestType: RequestType, data: Data, completion: @escaping () -> Void)
    
}
