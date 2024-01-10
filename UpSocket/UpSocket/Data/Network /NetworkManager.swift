//
//  MarketManager.swift
//  UpSocket
//
//  Created by yeoni on 12/27/23.
//

import Foundation
import Alamofire
import Combine

class NetworkManager {
    
    var candleModels: [CandleModel] = []
    var currentData: [CoinModel] = []
    static let shared = NetworkManager()
    
    private init() { }
    
    func fetchData<T: Decodable>(api: Router, type: T.Type, completion: @escaping (Result<T, Error>) -> ()) {
        AF.request(api)
            .validate()
            .responseDecodable(of: T.self) { response in
                print(response.result)
                switch response.result {
                case .success(let success):
                    completion(.success(success))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchMarket<T: Decodable>(api: Router, type: T.Type) -> AnyPublisher<T, AFError> {
        return AF.request(api)
            .validate()
            .publishDecodable(type: T.self)
            .flatMap({ response -> AnyPublisher<T, AFError> in
                // success
                if let decodedValue = response.value {
                    return Just(decodedValue)
                        .setFailureType(to: AFError.self)
                        .eraseToAnyPublisher()
                } else { // failure
                    let error = AFError.responseValidationFailed(reason: .dataFileNil)
                    return Fail(error: error).eraseToAnyPublisher()
                }
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
}
