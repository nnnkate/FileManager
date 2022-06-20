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
    
    // MARK: - Initialization
    
    private init() { }
    
    // MARK: - Keychain methods
    
    func getPassword() -> String? {
        keychain.get(KeychainKey.password.rawValue)
    }
    
    func setPassword(value: String) {
        keychain.set(value, forKey: KeychainKey.password.rawValue)
    }
}

enum KeychainKey: String {
    case password
}

