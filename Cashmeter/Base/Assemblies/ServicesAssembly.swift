//
//  ServicesAssembly.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation

final class ServicesAssembly {
    
    func receiptService() -> ReceiptService {
        let receiptService = ReceiptService()
        
        receiptService.networkProvider = networkProvider()
        
        return receiptService
    }
    
    func networkProvider() -> NetworkProviderProtocol {
        let networkProvider = NetworkProvider()
        
        return networkProvider
    }
    
}
