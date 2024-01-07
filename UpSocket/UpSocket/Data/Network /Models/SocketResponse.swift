//
//  SocketResponse.swift
//  UpSocket
//
//  Created by yeoni on 1/4/24.
//

import Foundation

struct SocketResponse: Decodable {
    var code: String
    var tradePrice: Double
    var change: Double
    var accTradePrice: Double
    
    enum CodingKeys: String, CodingKey {
        case code
        case change = "signed_change_rate"
        case tradePrice = "trade_price"
        case accTradePrice = "acc_trade_price"
    }
}
