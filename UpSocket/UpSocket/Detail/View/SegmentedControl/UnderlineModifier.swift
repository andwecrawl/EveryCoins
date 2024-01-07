//
//  UnderlineModifier.swift
//  UpSocket
//
//  Created by yeoni on 1/6/24.
//

import SwiftUI

struct UnderlineModifier: ViewModifier
{
    var selectedIndex: Int
    let frames: [CGRect]

    func body(content: Content) -> some View
    {
        content
            .background(
                Rectangle()
                    .fill(Color.mainYellow)
                    .frame(width: frames[selectedIndex].width, height: 2)
                    .offset(x: frames[selectedIndex].minX - frames[0].minX), alignment: .bottomLeading
            )
            .background(
                Rectangle()
                    .fill(Color.trustGray.opacity(0.9))
                    .frame(height: 1), alignment: .bottomLeading
            )
    }
}
