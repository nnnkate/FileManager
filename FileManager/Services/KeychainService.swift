//
//  KeychainService.swift
//  FileManager
//
//  Created by Екатерина Неделько on 14.06.22.
//

import KeychainSwift

class KeychainService {
    
    // MARK: - Public Properties
    
    static let shared = KeychainService()
    
    // MARK: - Private Properties
    
    private let keychain = KeychainSwift()
    
    private let keychainKey = "keychainKey"
    
    // MARK: - Initialization
    
    private init() { }
    
    // MARK: - Keychain methods
    
    func getKeychain() -> String? {
        keychain.get(keychainKey)
    }
    
    func getKeychain(value: String) {
        keychain.set(value, forKey: keychainKey)
    }
}

