//
//  Router.swift
//  UpSocket
//
//  Created by yeoni on 1/4/24.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    case marketName
    case currentCharge
    case candleCharts(marketName: String)
}

extension Router {
    var baseURL: URL {
        return URL(string: "https://api.upbit.com/v1/")!
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .marketName:
           return "market/all"
        case .currentCharge:
            return "ticker"
        case .candleCharts(_):
            return "candles/months"
        }
    }
   
    var parameters: Parameters {
        switch self {
        case .currentCharge:
            return [
                "markets": SocketManager.shared.codes.map { $0.market }.joined(separator: ",")
            ]
        case .candleCharts(let marketName):
            return [
                "market": marketName,
                "count": 40,
                "convertingPriceUnit": "KRW"
                
            ]
        default: return [:]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        
        switch self {
        case .currentCharge:
            request = try URLEncoding.default.encode(request, with: parameters)
        case .candleCharts(_):
            request = try URLEncoding.default.encode(request, with: parameters)
        default: break
        }
        
        return request
    }
    
    
}
