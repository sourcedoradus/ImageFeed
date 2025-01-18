//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Valentin Medvedev on 18.01.2025.
//

import Foundation

// MARK: - OAuth2TokenStorage Class

final class OAuth2TokenStorage {
    private let dataStorage =  UserDefaults.standard
    private let tokenKey = "token"
    
    var token: String? {
        get {
            dataStorage.string(forKey: tokenKey)
        }
        set {
            if let token = newValue {
                dataStorage.set(token, forKey: tokenKey)
            } else {
                dataStorage.removeObject(forKey: tokenKey)
            }
        }
    }
}
