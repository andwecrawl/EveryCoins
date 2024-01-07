//
//  DetailBannerView.swift
//  UpSocket
//
//  Created by yeoni on 1/6/24.
//

import SwiftUI

struct DetailBannerView: View {
    @State var coin: CoinModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.mainYellow.opacity(0.9))
                .overlay {
                    Circle()
                        .fill(.white.opacity(0.3))
                        .offset(x: -120, y: -20)
                        .scaleEffect(1.6, anchor: .topLeading)
                        .frame(width: 200, height: 200)
                }
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .frame(maxWidth: .infinity)
                .frame(height: 100)
            HStack {
                VStack(alignment: .leading) {
                    Text(coin.korName)
                        .font(.title)
                        .bold()
                    Text(coin.marketCode)
                        .font(.title3)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(coin.tradePrice.toString())
                        .font(.body)
                        .bold()
                    Group {
                        Text(coin.change.percentToString() + "%")
                        Text(coin.changePrice.toString())
                    }
                    .font(.subheadline)
                }
                .foregroundStyle(coin.change < 0 ? Color.trustBlue : .red)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
        .padding(.top)
        .padding(.bottom, 5)
    }
}
