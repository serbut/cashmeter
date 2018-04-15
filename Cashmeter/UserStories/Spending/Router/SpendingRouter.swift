//
//  SpendingRouter.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

final class SpendingRouter: SpendingRouterInput {
    
    weak var transitionHandler: SpendingViewController!
    
    func showScanQrModule() {
        print("Opening QR module")
    }
    
}
