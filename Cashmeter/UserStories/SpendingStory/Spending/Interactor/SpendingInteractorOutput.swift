//
//  SpendingInteractorOutput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 22/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

protocol SpendingInteractorOutput: class {
    
    /**
     Метод сообщает, что парсинг чека завершился успешно.
     
     @param receiptInfo - распаршенные данные чека.
     */
    func didParsedReceipt(with receiptInfo: ReceiptInfo)
    
    /**
     Метод сообщает, что парсинг чека завершился с ошибкой.
     
     @param error - ошибка.
     */
    func didFailParseReceipt(error: String)
    
}
