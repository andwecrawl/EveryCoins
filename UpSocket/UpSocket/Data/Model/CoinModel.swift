//
//  CoinModel.swift
//  UpSocket
//
//  Created by yeoni on 1/5/24.
//

import Foundation

struct CoinModel: Hashable, Identifiable {
    let id = UUID()
    let korName: String
    let engName: String
    let marketCode: String
    var tradePrice: Double
    var change: Double
    var changePrice: Double
    var accTradePrice: Double
    
    mutating func applySocketResponse(response: SocketResponse) {
        self.tradePrice = response.tradePrice
        self.accTradePrice = response.accTradePrice
        self.change = response.change
    }
    
    init(names: MarketName, information: CoinInformation) {
        self.korName = names.koreanName
        self.engName = names.englishName
        self.marketCode = names.market
        self.tradePrice = information.tradePrice
        self.change = information.change
        self.changePrice = information.changePrice
        self.accTradePrice = information.accTradePrice
    }
}
