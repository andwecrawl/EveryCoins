//
//  DetailView.swift
//  UpSocket
//
//  Created by yeoni on 1/6/24.
//

import SwiftUI

struct DetailView: View {
    @StateObject
    var viewModel: DetailViewModel
    
    @State var selectedIndex = 0
    @State var liked = false
    let titles = ["주문", "호가", "차트", "시세", "정보"]
    
    var body: some View {
        NavigationStack {
            VStack {
                DetailBannerView(coin: viewModel.coin)
                SegmentedControlView(selectedIndex: $selectedIndex, titles: titles)
                    .animation(.default, value: selectedIndex)
                    .frame(maxWidth: .infinity)
                
                switch selectedIndex {
                case 0:
                    HStack {
                        BarGraphView(viewModel: DetailViewModel(coin: viewModel.coin))
                        SideView(price: viewModel.coin.tradePrice.toString())
                    }
                default:
                    WaitingView()
                }
                Spacer()
            }
        }
        .navigationTitle(viewModel.coin.korName + "(\(viewModel.coin.marketCode))")
        .onAppear(perform: {
            if UserDefaultsHelper.shared.likedCoinCodes.contains(viewModel.coin.marketCode) {
                print("I liked it")
                liked = true
            }
        })
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    if liked {
                        let filteredArray = UserDefaultsHelper.shared.likedCoinCodes.filter { $0 != viewModel.coin.marketCode }
                        UserDefaultsHelper.shared.likedCoinCodes = filteredArray
                    } else {
                        UserDefaultsHelper.shared.likedCoinCodes.append(viewModel.coin.marketCode)
                    }
                    liked.toggle()
                }, label: {
                    liked ? Image(systemName: "star.fill") : Image(systemName: "star")
                })
            }
        })
    }
}
