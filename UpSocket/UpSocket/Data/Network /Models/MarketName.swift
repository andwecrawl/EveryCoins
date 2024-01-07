//
//  Model.swift
//  UpSocket
//
//  Created by yeoni on 12/27/23.
//

import Foundation

struct MarketName: Decodable {
    let market, koreanName, englishName: String

    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
    }
}

struct CoinInformation: Decodable {
    var market: String
    var tradePrice: Double
    var change: Double
    var changePrice: Double
    var accTradePrice: Double
    
    enum CodingKeys: String, CodingKey {
        case market
        case change = "signed_change_rate"
        case changePrice = "signed_change_price"
        case tradePrice = "trade_price"
        case accTradePrice = "acc_trade_price"
    }
}
