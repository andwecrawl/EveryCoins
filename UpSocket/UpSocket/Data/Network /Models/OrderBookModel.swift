//
//  OrderBookModel.swift
//  UpSocket
//
//  Created by yeoni on 1/6/24.
//

import Foundation

struct OrderBookModel: Decodable {
    let code: String
    let totalAskSize, totalBidSize: Double
    let orderbookUnits: [OrderBookUnit]
    
    enum CodingKeys: String, CodingKey {
        case code
        case totalAskSize = "total_ask_size"
        case totalBidSize = "total_bid_size"
        case orderbookUnits = "orderbook_units"
    }
}

struct OrderBookUnit: Decodable {
    let askPrice, bidPrice: Double
    let askSize, bidSize: Double
    
    enum CodingKeys: String, CodingKey {
        case askPrice = "ask_price"
        case bidPrice = "bid_price"
        case askSize = "ask_size"
        case bidSize = "bid_size"
    }
}

struct OrderBookItem: Hashable, Identifiable {
    let id = UUID()
    let price: Double
    let size: Double
}
