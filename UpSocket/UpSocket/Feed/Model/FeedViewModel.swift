//
//  ContentViewModel.swift
//  UpSocket
//
//  Created by yeoni on 12/27/23.
//

import Foundation
import Combine

class FeedViewModel: ObservableObject {
    
    @Published 
    var showingCoinList: [CoinModel] = []
    
    @Published
    var coinList: [CoinModel] = []
    
    var coinCodes: [String] = []
    let searchQuery = CurrentValueSubject<String, Never>("")
    
    private var cancellbae = Set<AnyCancellable>()
    
    
    init() {
        fetchMarketName()
        bind()
    }
    
    func bind() {
        searchQuery
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { [weak self] str in
                self?.search(str: str)
            }
            .store(in: &cancellbae)
        
        SocketManager.shared.coinData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] order in
                print("========================================")
                guard let self else { return }
                print(order)
                for index in self.coinList.indices {
                    if self.coinList[index].marketCode == order.code {
                        self.coinList[index].applySocketResponse(response: order)
                        print("\(coinList[index].korName): has changed!!!!!")
                    }
                }
            }
            .store(in: &cancellbae)
    }
    
    
    func fetchMarketName() {
        NetworkManager.shared.fetchData(api: .marketName, type: [MarketName].self) { [weak self] response in
            switch response {
            case .success(let value):
                SocketManager.shared.codes = value
                self?.fetchFeedData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchFeedData() {
        
        NetworkManager.shared.fetchData(api: .currentCharge, type: [CoinInformation].self) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let value):
                
                var list: [CoinModel] = []
                for element in value {
                    if let names = SocketManager.shared.codes.filter({ $0.market == element.market }).first {
                        list.append(CoinModel(names: names, information: element))
                    }
                }
                self.coinList = list.filter({ $0.tradePrice > 1  && $0.accTradePrice.toFormattedString() != "0백만" })
                self.showingCoinList = self.coinList
                
                WalletManager.shared.coinModels = list
                self.coinCodes = list.map { $0.marketCode }
                
                self.manageSocket()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func manageSocket() {
        SocketManager.shared.request = self.coinCodes
        SocketManager.shared.openWebSocket()
        SocketManager.shared.send()
    }
    
    func search(str: String) {
        if str == "" {
            showingCoinList = coinList
        } else {
            let newValue = coinList.filter { $0.korName.contains(str) || $0.engName.contains(str) }
            showingCoinList = newValue
        }
    }
    
}

