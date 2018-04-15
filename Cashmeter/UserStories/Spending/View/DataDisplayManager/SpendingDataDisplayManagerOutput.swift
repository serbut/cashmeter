//
//  SpendingDataDisplayManagerOutput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

protocol SpendingDataDisplayManagerOutput: class {
    
    /**
     Метод сообщает о том, что пользователь нажал на кнопку
     */
    func didTapButton(with type: SpendingButtonType)
    
    /**
     Метод сообщает о том, что пользователь нажал на ячейку сканирования QR-кода
     */
    func didTriggerScanQrAction()
    
}
