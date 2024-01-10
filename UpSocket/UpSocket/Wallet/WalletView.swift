//
//  WalletView.swift
//  UpSocket
//
//  Created by yeoni on 1/6/24.
//

import SwiftUI

struct WalletView: View {
    
    @State private var isExpandable = false // animation
    @State private var showDetail = false // transition
    
    @State private var currentWallet = WalletManager.shared.walletList.first!
    
    
    @Namespace var animations
    
    var body: some View {
        VStack {
            topTitle()
            cardSpace()
        }
        .overlay {
            if showDetail {
                WalletDetailView(
                    showDetail: $showDetail,
                    currentWallet: currentWallet,
                    animation: animations
                )
            }
        }
        .onAppear(perform: {
            WalletManager.shared.fetchLikedCoins()
        })
    }
    
    
    func cardSpace() -> some View {
        ScrollView {
            ForEach(WalletManager.shared.walletList, id: \.self) { card in
                cardView(card)
            }
        }
        .overlay {
            Rectangle()
                .fill(.black.opacity(isExpandable ? 0 : 0.01))
                .onTapGesture {
                    withAnimation {
                        isExpandable = true
                    }
                }
        }
    }
    
    
    func cardView(_ data: WalletModel) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(data.color)
                .frame(height: 150)
                .overlay {
                    Circle()
                        .fill(.white.opacity(0.3))
                        .offset(x: -120, y: -40)
                        .scaleEffect(1.6, anchor: .topLeading)
                        .frame(width: 200, height: 200)
                }
                .clipShape(RoundedRectangle(cornerRadius: 25))
            HStack {
                VStack(alignment: .leading) {
                    Text(data.korName)
                        .font(.title.bold())
                    Text(data.marketCode)
                        .font(.title3)
                }
                Spacer()
                VStack(alignment: .trailing, content: {
                    Text("현재가: \(data.tradePrice.toString())")
                    Text("전일대비: \(data.change.percentToString())")
                    Text("\(data.changePrice.toString())")
                })
                .foregroundStyle(data.tradePrice > 0 ? .red : .blue)
            }
            .padding()
        }
        .padding(.horizontal)
        .padding(.vertical, 3)
        .offset(y: CGFloat(data.index) * ( isExpandable ? 0 : -100))
        .onTapGesture {
            withAnimation {
                showDetail = true
                currentWallet = data
            }
        }
        .matchedGeometryEffect(id: data, in: animations)
    }
    
    func topTitle() -> some View {
        Text("나의 지갑")
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: isExpandable ? .leading : .center)
            .overlay(alignment: .trailing) {
                topOverlayButton()
            }
            .padding()
        
    }
    
    func topOverlayButton() -> some View {
        Button {
            withAnimation {
                isExpandable.toggle()
            }
        } label: {
            Image(systemName: "plus")
                .padding()
                .foregroundStyle(.white)
                .background(.black, in: Circle())
                .rotationEffect(.degrees(isExpandable ? 225 : 45))
        }
        .opacity(isExpandable ? 1 : 0)
        
    }
}

#Preview {
    WalletView()
}
