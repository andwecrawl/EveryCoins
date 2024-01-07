//
//  TabView.swift
//  UpSocket
//
//  Created by yeoni on 1/4/24.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            FeedView(viewModel: FeedViewModel(), searchQueryString: "")
                .tabItem {
                    Image(systemName: "bitcoinsign.circle")
                    Text("Exchange")
                }
            WalletView()
                .tabItem {
                    Image(systemName: "wallet.pass")
                    Text("Wallet")
                }
            LoginView()
                .tabItem{
                    Image(systemName: "gearshape.fill")
                    Text("Login")
                }
        }
        .tint(.mainYellow)
    }
}

#Preview {
    TabBarView()
}
