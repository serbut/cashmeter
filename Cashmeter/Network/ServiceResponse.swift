//
//  ServiceResponse.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 22/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

enum ServiceResponse<T> {
    
    case success(result: T)
    case error(error: Error)
    
}
