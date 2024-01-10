//
//  CoinWidgetsBundle.swift
//  CoinWidgets
//
//  Created by yeoni on 1/6/24.
//

import WidgetKit
import SwiftUI

@main
struct CoinWidgetsBundle: WidgetBundle {
    var body: some Widget {
        CoinWidgets()
        TextWidget()
        CoinWidgetsLiveActivity()
    }
}
