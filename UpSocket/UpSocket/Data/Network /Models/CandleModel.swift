//
//  CandleModel.swift
//  UpSocket
//
//  Created by yeoni on 1/8/24.
//

import Foundation

struct CandleModel: Decodable, Identifiable {
    let id = UUID()
    let market: String
    let timestamp: UInt64
    let openingPrice: Double // 시가
    let highPrice: Double // 고가
    let lowPrice: Double // 저가
    let tradePrice: Double // 종가
    
    var date: Date {
        return Date(timeIntervalSince1970: TimeInterval(timestamp))
    }
    
    enum CodingKeys: String, CodingKey {
        case market, timestamp
        case openingPrice = "opening_price"
        case highPrice = "high_price"
        case lowPrice = "low_price"
        case tradePrice = "trade_price"
    }
}
