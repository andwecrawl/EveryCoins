//
//  BarGraphView.swift
//  UpSocket
//
//  Created by yeoni on 1/6/24.
//

import SwiftUI

struct BarGraphView: View {
    
    @StateObject var viewModel: DetailViewModel
    
    var body: some View {
        ScrollView {
            GeometryReader { proxy in // 상위뷰에 대한 크기를 가져올 수 있음
                
                let graphWidth = proxy.size.width * 0.7 // 차트 최대 너비
                
                LazyVStack {
                    ForEach(viewModel.askOrderBook, id: \.id) { item in
                        HStack {
                            
                            Text("\(item.price.formatted())")
                                .font(.caption2)
                                .frame(width: graphWidth * 0.3)
                            ZStack(alignment: .leading) {
                                
                                let graphSize = CGFloat(item.size) / CGFloat(viewModel.largestAskSize()) * graphWidth
                                
                                Rectangle()
                                    .foregroundStyle(.blue.opacity(0.4))
                                    .frame(maxWidth: graphSize, alignment: .leading)
                                Text(item.size.formatted())
                                    .frame(width: graphWidth)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .frame(height: 40)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

