//
//  CoinWidgets.swift
//  CoinWidgets
//
//  Created by yeoni on 1/6/24.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    
    init() {
        getData()
    }
    
    func getData() {
        NetworkManager.shared.fetchData(api: .candleCharts(marketName: "KRW-BTC"), type: [CandleModel].self) { result in
            switch result {
            case .success(let success):
                NetworkManager.shared.candleModels = success
            case .failure(let failure):
                print("error: \(failure)")
            }
        }
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), models: NetworkManager.shared.candleModels)
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration, models: NetworkManager.shared.candleModels)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, models: NetworkManager.shared.candleModels)
            entries.append(entry)
        }
        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    var models: [CandleModel]
}

struct CoinWidgetsEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(.white.gradient)
            VStack(alignment: .leading) {
                Text("🪙 Bitcoin")
                    .font(.headline).bold()
                ChartView(candles: entry.models)
            }
            .padding()
        }
    }
}

struct TextWidgetEntryView : View {
    var entry: Provider.Entry
    let currentWallet = NetworkManager.shared.currentData.last!
    
    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(.white.gradient)
            VStack(alignment: .leading) {
                Text("🪙 Bitcoin")
                    .font(.headline).bold()
                Text("현재가: \(currentWallet.tradePrice.toString())")
                Text("전일대비: \(currentWallet.change.percentToString())")
                Text("\(currentWallet.changePrice.toString())")
            }
            .padding()
        }
    }
}

struct TextWidget: Widget {
    let kind: String = "TextWidgets" // 위젯의 고유한 문자열
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            CoinWidgetsEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("관심있는 코인")
        .description("실시간 시세를 확인하세요!")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .accessoryCircular, .accessoryInline, .accessoryRectangular])
        .contentMarginsDisabled()
    }
}

struct CoinWidgets: Widget {
    let kind: String = "CoinWidgets" // 위젯의 고유한 문자열
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            CoinWidgetsEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("관심있는 코인")
        .description("실시간 시세를 확인하세요!")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .accessoryCircular, .accessoryInline, .accessoryRectangular])
        .contentMarginsDisabled()
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.coinType = "KRW-BTC"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.coinType = "KRW-ETC"
        return intent
    }
}

//#Preview(as: .systemSmall) {
//    CoinWidgets()
//} timeline: {
//    SimpleEntry(date: .now, configuration: .smiley, models: )
//    SimpleEntry(date: .now, configuration: .starEyes)
//}
