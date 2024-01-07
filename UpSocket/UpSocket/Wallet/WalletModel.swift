//
//  WalletModel.swift
//  UpSocket
//
//  Created by yeoni on 1/6/24.
//

import SwiftUI

struct WalletModel: Hashable {
    let color = Color.random()
    let index: Int
    let korName: String
    let engName: String
    let marketCode: String
    var tradePrice: Double
    var change: Double
    var changePrice: Double
    var accTradePrice: Double
    
    init(index: Int, coin: CoinModel) {
        self.index = index
        self.korName = coin.korName
        self.engName = coin.engName
        self.marketCode = coin.marketCode
        self.tradePrice = coin.tradePrice
        self.change = coin.change
        self.changePrice = coin.changePrice
        self.accTradePrice = coin.accTradePrice
    }
}

class WalletManager {
    
    static let shared = WalletManager()
    private init() { }
    
    var coinModels: [CoinModel] = []
    var walletList: [WalletModel] = [WalletModel(index: 0, coin: CoinModel(names: MarketName(market: "임시", koreanName: "임시", englishName: "임시"), information: CoinInformation(market: "", tradePrice: 0, change: 0, changePrice: 0, accTradePrice: 0)))]
    
    func fetchLikedCoins() {
        walletList = []
        
        for index in UserDefaultsHelper.shared.likedCoinCodes.indices {
            let likedCode = UserDefaultsHelper.shared.likedCoinCodes[index]
            let model = coinModels.filter { $0.marketCode == likedCode }.first!
            
            let walletModel = WalletModel(index: index, coin: model)
            walletList.append(walletModel)
        }
        
        
    }
    
}
