//
//  AuthorizationService.swift
//  FileManager
//
//  Created by Екатерина Неделько on 14.06.22.
//

import Foundation
import LocalAuthentication

class AuthorizationService {
    
    // MARK: - Public Properties
    
    static let shared = AuthorizationService()
    
    weak var delegate: AuthorizationServiceDelegate?
    
    // MARK: - Initialization
    
    private init() { }
    
    // MARK: - Authorization methods
    
    func runAuthorization() {
        guard let password = KeychainService.shared.getKeychain() else {
            requestAuthorization()
            return
        }
        
        faceIDAutorization() {  result in
            if !result {
                self.passwordIDAutorization(password: password)
            }
        }
    }
    
    private func passwordIDAutorization(password: String) {
        self.delegate?.handlePasswordIDAutorization() { enteredPassword in
            if enteredPassword != password {
                self.passwordIDAutorization(password: password)
            }
        }
    }
    
    private func faceIDAutorization(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            }
        } else {
            completion(false)
        }
    }
    
    func requestAuthorization() {
        self.delegate?.handlePasswordSetting() { enteredPassword in
            KeychainService.shared.setKeychain(value: enteredPassword)
        }
    }
}
