//
//  UserDefaultsHelper.swift
//  UpSocket
//
//  Created by yeoni on 1/6/24.
//

import Foundation

final class UserDefaultsHelper {
    
    static let shared = UserDefaultsHelper()
    
    private init() { }
    
    private let userDefaults = UserDefaults.standard
    
    var likedCoinCodes: [String] {
        get {
            return userDefaults.stringArray(forKey: "likedCoinCodes") ?? []
        }
        set {
            userDefaults.set(newValue, forKey: "likedCoinCodes")
        }
    }
}
