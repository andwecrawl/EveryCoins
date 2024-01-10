//
//  Charts.swift
//  UpSocket
//
//  Created by yeoni on 1/8/24.
//

import SwiftUI
import Charts

struct ChartView: View {
    let curGradient = LinearGradient(
        gradient: Gradient (
            colors: [
                .red.opacity(0.5),
                .red.opacity(0.2),
                .red.opacity(0.05),
            ]
        ),
        startPoint: .top, endPoint: .bottom)
    
    @State
    var candles: [CandleModel]
    
    var body: some View {
        VStack {
            Chart {
                ForEach(candles) { item in
                    LineMark(
                        x: .value("time", item.date),
                        y: .value("price", item.tradePrice)
                    )
                    .foregroundStyle(.red)
                    
                    AreaMark(
                        x: .value("time", item.date),
                        y: .value("price", item.tradePrice)
                    )
                    .foregroundStyle(curGradient)
                }
            }
        }
    }
}

#Preview {
    ChartView(candles: [])
}
