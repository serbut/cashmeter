//
//  QRScannerModuleOutput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 15/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

protocol QRScannerModuleOutput {
    
    /**
     Метод сообщает о том, что сканирование завершено
     
     @param scannedString - отсканированная строка
    */
    func scanIsFinished(_ scannedString: String)
    
}
