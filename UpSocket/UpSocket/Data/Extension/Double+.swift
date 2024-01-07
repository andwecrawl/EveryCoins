//
//  Double+.swift
//  UpSocket
//
//  Created by yeoni on 1/5/24.
//

import Foundation

extension Double {
    func toString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.roundingMode = .floor
        numberFormatter.maximumFractionDigits = 3
        return numberFormatter.string(for: self)!
    }
    
    func percentToString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.roundingMode = .floor
        numberFormatter.maximumFractionDigits = 2
        let num = self * 100
        return numberFormatter.string(for: num)!
    }
    
    func toFormattedString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let cutMillion = Int(self / 1000000)
        let numStr = numberFormatter.string(for: cutMillion)!
        return numStr + "백만"
    }
}
