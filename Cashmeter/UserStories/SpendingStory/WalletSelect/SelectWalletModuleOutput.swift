//
//  SelectWalletModuleOutput.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 12/05/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

protocol SelectWalletModuleOutput {
    
    /**
     Метод сообщает о том, что был выбран кошелек.
     
     @param wallet - выбранный кошелек
     */
    func didSelectWallet(_ wallet: Wallet)
    
}
