//
//  File.swift
//  UpSocket
//
//  Created by yeoni on 1/6/24.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    var coin: CoinModel
    
    @Published var askOrderBook: [OrderBookItem] = []
    @Published var bidOrderBook: [OrderBookItem] = []
    
    private var cancellbae = Set<AnyCancellable>()
    
    
    init(coin: CoinModel) {
        self.coin = coin
        bindToSocket()
        manageWebSocket()
    }
    
    deinit {
        SocketManager.shared.closeWebSocket()
        SocketManager.shared.request = []
    }
    
    func bindToSocket() {
        SocketManager.shared.orderbookData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] order in
                print("========================================")
                guard let self else { return }
                print(order)
                
                order.orderbookUnits.forEach {
                    self.askOrderBook.append(OrderBookItem(price: $0.askSize, size: $0.askSize))
                    self.bidOrderBook.append(OrderBookItem(price: $0.bidPrice, size: $0.bidSize))
                }
                
                self.askOrderBook.sort(by: { $0.price > $1.price })
                self.bidOrderBook.sort(by: { $0.price > $1.price })
                print("========== askOrderBook \(self.askOrderBook)")
                print("========== bidOrderBook \(self.bidOrderBook)")
            }
            .store(in: &cancellbae)
    }
    
    func manageWebSocket() {
        SocketManager.shared.request = ["\(coin.marketCode).15"]
        SocketManager.shared.openWebSocket()
        SocketManager.shared.send()
    }
    
    
    
    func largestAskSize() -> Double {
        return askOrderBook.sorted(by: { $0.size > $1.size }).first?.size ?? 0
    }
    
    func largestBidSize() -> Double {
        return bidOrderBook.sorted(by: { $0.size > $1.size }).first?.size ?? 0
    }
}
