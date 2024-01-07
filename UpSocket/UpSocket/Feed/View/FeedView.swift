//
//  ContentView.swift
//  UpSocket
//
//  Created by yeoni on 12/27/23.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject
    var viewModel: FeedViewModel
    @State var searchQueryString = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Image(.coin)
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .frame(width: 40, height: 40)
                    .padding(.top, 4)
                
                SearchBarView(searchText: $searchQueryString)                    .onSubmit(of: .text) {
                        viewModel.searchQuery.send(searchQueryString)
                    }
                
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    Section {
                        ForEach(viewModel.showingCoinList, id: \.id) { item in
                            NavigationLink {
                                DetailView(viewModel: DetailViewModel(coin: item))
                            } label: {
                                CoinCell(coin: item)
                                    .frame(maxWidth: .infinity)
                            }
                            
                            Rectangle()
                                .fill(.trustGray.opacity(0.6))
                                .frame(height: 1)
                                .frame(maxWidth: 420)
                        }
                    } header: {
                        ExchangeHeader()
                            .frame(maxWidth: .infinity)
                    }
                }
                
            }
            .clipped()
            .navigationBarTitle("", displayMode: .inline)
            .onAppear {
                if !viewModel.coinList.isEmpty {
                    viewModel.manageSocket()
                }
            }
            .onDisappear {
                SocketManager.shared.closeWebSocket()
            }
        }
    }
}
