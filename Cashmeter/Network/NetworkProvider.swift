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
    
    func sendRequest(_ requestType: RequestType, parameters: Parameters?, completion: @escaping (NetworkProviderResponse) -> Void) {

        let requestUrl = baseUrl + requestType.rawValue

        Alamofire.request(requestUrl,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: [:])
            .responseJSON { response in
                switch(response.result) {
                case .success(_):
                    if let data = response.data {
                        completion(.success(result: data))
                    } else {
                        // TODO: Do something
                        print("Error - no data")
                    }
                case .failure(let error):
                    completion(.error(error: error))
                }
        }
        
    }
}
