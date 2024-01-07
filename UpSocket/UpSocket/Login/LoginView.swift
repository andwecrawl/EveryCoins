//
//  LoginView.swift
//  UpSocket
//
//  Created by yeoni on 1/1/24.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack {
            Color(.mainYellow).ignoresSafeArea()
            LazyVStack {
                Image("logo2")
                    .resizable()
                    .frame(width: 200, height: 200)
                Spacer(minLength: 10)
                LoginButtonView()
            }
        }
    }
}

#Preview {
    LoginView()
}

struct LoginButtonView: View {
    var body: some View {
        Group {
            Button {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.white)
                        .frame(width: 330, height: 50)
                    Text("카카오 로그인")
                        .foregroundStyle(.black)
                    
                }
            }
            
            Button {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.white)
                        .frame(width: 330, height: 50)
                    Text("애플 로그인")
                        .foregroundStyle(.black)
                }
            }
            
            Button {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.white)
                        .frame(width: 330, height: 50)
                    Text("이메일 로그인")
                        .foregroundStyle(.black)
                }
            }
        }
    }
}
