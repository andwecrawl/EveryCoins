//
//  Color+.swift
//  UpSocket
//
//  Created by yeoni on 1/6/24.
//

import SwiftUI

extension Color {
    static func random() -> Color {
        return Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
    }
    
}
