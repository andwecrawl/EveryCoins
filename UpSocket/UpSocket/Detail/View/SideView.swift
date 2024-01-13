//
//  SideView.swift
//  UpSocket
//
//  Created by yeoni on 1/6/24.
//

import SwiftUI

struct SideView: View {
    @State var buySelected = true
    @State var nums: String = "0"
    @State var price: String
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    buySelected = true
                } label: {
                    if buySelected { // 클릭시
                        ZStack {
                            Color.black
                            Text("매수")
                                .bold()
                        }
                    } else {
                        ZStack {
                            Color.white.opacity(0.2)
                            Text("매수")
                                .bold()
                        }
                    }
                }
                
                Button {
                    buySelected = false
                } label: {
                    if !buySelected { // 클릭 시
                        ZStack {
                            Color.black
                            Text("매도")
                                .bold()
                        }
                    } else {
                        ZStack {
                            Color.white.opacity(0.2)
                            Text("매도")
                        }
                    }
                }
            }
            .font(.subheadline)
            .frame(height: 30)
            
            HStack {
                Text("주문 가능")
                Spacer()
                Text("- KRW")
                    .bold()
            }
            .padding(5)
            
            HStack {
                Text("수량")
                Spacer()
                TextField("", text: $nums)
                    .multilineTextAlignment(.trailing)
            }
            .padding(5)
            
            HStack {
                Text("가격")
                Spacer()
                TextField("", text: $price)
                    .multilineTextAlignment(.trailing)
            }
            .padding(5)
            
            
            HStack {
                Text("총액")
                Spacer()
                Text("- KRW")
            }
            .padding(5)
            
            Button {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(.mainYellow)
                        .frame(height: 40)
                    Text("로그인")
                        .foregroundStyle(.white)
                }
            }
            .padding(5)
            
            Spacer()
        }
    }
}

#Preview {
    SideView(price: "12312312")
}
