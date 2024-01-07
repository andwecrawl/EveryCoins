//
//  ExchangeHeader.swift
//  UpSocket
//
//  Created by yeoni on 1/6/24.
//

import SwiftUI

struct ExchangeHeader: View {
    var body: some View {
        ZStack {
            Color(.black)
            VStack {
                HStack(alignment: .center) {
                    LazyVStack(alignment: .leading) {
                        HStack {
                            Text("코인 이름")
                            Image(systemName: "arrow.left.arrow.right")
                                .font(.caption2)
                        }
                    }
                    .frame(minWidth: 100)
                    .padding()
                    Group {
                        SubtitleView(name: "현재가")
                        SubtitleView(name: "전일대비")
                        SubtitleView(name: "거래대금")
                            .padding(.trailing, 10)
                    }
                    .padding(.trailing, 4)
                }
                .font(.footnote.bold())
                .frame(height: 20)
                
                Rectangle()
                    .fill(.trustGray)
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
            }
            .padding(.top, 10)
        }
    }
}

struct SubtitleView: View {
    @State var name: String
    
    var body: some View {
        HStack {
            Text(name)
            Image(systemName: "arrow.up.arrow.down")
                .font(.caption2)
        }
        .frame(width: 80)
    }
}
