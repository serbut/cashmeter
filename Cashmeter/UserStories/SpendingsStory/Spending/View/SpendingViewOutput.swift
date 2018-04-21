//
//  SpendingViewOutput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

protocol SpendingViewOutput: class {
    
    /**
     Метод сообщает о том, что view загрузилась
     */
    func viewIsReady()
    
    /**
     Метод сообщает о том, что пользователь нажал на кнопку
     */
    func didTapButton(with type: SpendingButtonType)
    
    /**
     Метод сообщает о том, что пользователь нажал на ячейку сканирования QR-кода
     */
    func didTriggerScanQrAction()
    
    /**
     Метод сообщает о том, что пользователь нажал на кнопку закрытия модуля.
     */
    func didTapOnClose()
    
}
