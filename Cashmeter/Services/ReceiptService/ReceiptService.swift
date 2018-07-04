//
//  ReceiptService.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 11/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation

final class ReceiptService: BaseService {
    
}

// MARK: ReceiptServiceInput

extension ReceiptService: ReceiptServiceInput {

    func parse(_ receiptData: ReceiptData, with completion: @escaping (ServiceResponse<ReceiptInfo>) -> Void) {
        
        let params = ["fp": receiptData.fp,
                      "i": receiptData.i,
                      "fn": receiptData.fn]
        
        networkProvider.sendRequest(.parse, parameters: params) { (response: NetworkProviderResponse) in
            switch response {
            case let .success(result):
                let decoder = JSONDecoder()
                do {
                    let receiptInfo = try decoder.decode(ReceiptInfo.self, from: result)
                    completion(.success(result: receiptInfo))
                } catch let error {
                    completion(.error(error: error))
                }
            case let .error(error):
                completion(.error(error: error))
            }
        }
    }
    
}

// MARK: Mapping


