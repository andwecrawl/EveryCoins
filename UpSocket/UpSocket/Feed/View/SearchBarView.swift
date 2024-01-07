//
//  SearchBarView.swift
//  UpSocket
//
//  Created by yeoni on 1/6/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? .gray : .black)
            
            TextField("", text: $searchText,
                      prompt: Text("코인명을 검색해 보세요!").foregroundStyle(.gray))
                .autocorrectionDisabled(true)
                .foregroundColor(Color.black)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(.mainYellow)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            searchText = ""
                            UIApplication.shared.endEditing()
                        }
                    , alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(.white.opacity(0.9))
                .shadow(
                    color: Color.gray.opacity(0.4),
                    radius: 10, x: 0, y: 0)
        )
        .padding()
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
