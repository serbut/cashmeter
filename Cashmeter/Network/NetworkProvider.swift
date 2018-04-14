//
//  NetworkProvider.swift
//  Cashmeter
//
//  Created by Sergey Butorin on 14/04/2018.
//  Copyright © 2018 Sergey Butorin. All rights reserved.
//

import Foundation
import Alamofire

final class NetworkProvider {
    
    let baseUrl = "http://194.87.110.156:8888"
    
}

// MARK: NetworkProviderProtocol

extension NetworkProvider: NetworkProviderProtocol {
    func sendRequest(_ requestType: RequestType, data: Data, completion: @escaping () -> Void) {

        let requestUrl = baseUrl + requestType.rawValue
        let params = ["fp": "1740507959", "i": "981", "fn": "8710000101503795"]

        Alamofire.request(requestUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON
            { response in
                switch(response.result) {
                case .success(_):
                    if response.result.value != nil{
                        print("Uploaded")
                        print(response)
                        completion()
                    }
                    break
                    
                case .failure(_):
                    print("Failure : \(response.result.error)")
                    break
                }
        }
    }
}
