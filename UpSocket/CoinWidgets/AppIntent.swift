//
//  AppIntent.swift
//  CoinWidgets
//
//  Created by yeoni on 1/6/24.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    // An example configurable parameter.
    @Parameter(title: "My Wallets", default: "KRW-BTC")
    var coinType: String
}
