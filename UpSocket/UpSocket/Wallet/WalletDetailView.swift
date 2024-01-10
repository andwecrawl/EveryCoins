//
//  WalletViewModel.swift
//  UpSocket
//
//  Created by yeoni on 1/6/24.
//

import SwiftUI

struct WalletDetailView: View {
    
    @Binding var showDetail: Bool // 화면 dismiss(overlay false)
    
    let currentWallet: WalletModel // WalletView에서 선택한 card 정보
    var animation: Namespace.ID
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8).ignoresSafeArea()
            RoundedRectangle(cornerRadius: 25)
                .fill(currentWallet.color)
                .frame(height: 150)
                .overlay {
                    Circle()
                        .fill(.white.opacity(0.3))
                        .offset(x: -120, y: -40)
                        .scaleEffect(1.6, anchor: .topLeading)
                        .frame(width: 200, height: 200)
                }
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .onTapGesture {
                    withAnimation {
                        showDetail = false
                    }
                }
                .matchedGeometryEffect(id: currentWallet, in: animation)
            HStack {
                VStack(alignment: .leading) {
                    Text(currentWallet.korName)
                        .font(.title.bold())
                    Text(currentWallet.marketCode)
                        .font(.title3)
                }
                Spacer()
                VStack(alignment: .trailing, content: {
                    Text("현재가: \(currentWallet.tradePrice.toString())")
                    Text("전일대비: \(currentWallet.change.percentToString())")
                    Text("\(currentWallet.changePrice.toString())")
                })
                .foregroundStyle(currentWallet.tradePrice > 0 ? .red : .blue)
            }
            .padding()
            .onTapGesture {
                withAnimation {
                    showDetail = false
                }
            }
        }
    }
}
