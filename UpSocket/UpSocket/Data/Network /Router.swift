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
        }
    }
   
    var parameters: Parameters {
        [
            "markets": SocketManager.shared.codes.map { $0.market }.joined(separator: ",")
        ]
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        
        if self == .currentCharge {
            print(parameters)
            request = try URLEncoding.default.encode(request, with: parameters)
        }
        
        return request
    }
    
    
}
