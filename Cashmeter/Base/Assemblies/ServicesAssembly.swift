//
//  ServicesAssembly.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import UIKit

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
    
    func spendingsListService() -> SpendingsListService {
        let coreDataStack = (UIApplication.shared.delegate as? AppDelegate)!.coreDataStack
        let spendingsListService = SpendingsListService(with: coreDataStack)
        
        return spendingsListService
    }
    
}
