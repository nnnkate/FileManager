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
    
    var delegate: AuthorizationServiceDelegate?
    
    // MARK: - Initialization
    
    private init() { }
    
    // MARK: - Authorization methods
    
    func runAuthorization() {
        guard let password = KeychainService.shared.getKeychain() else {
            requestAuthorization()
            return
        }
        
        faceIDAutorization()
        passwordIDAutorization()
    }
    
    private func passwordIDAutorization() {
        
        
    }
    
    private func faceIDAutorization() {
        let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Identify yourself!"

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                    [weak self] success, authenticationError in
                    DispatchQueue.main.async {
                        if success {
                            print("aaa")
                        } else {
                            self?.delegate?.handleErrorFaceIDAuthorization()
                        }
                    }
                }
            } else {
                self.delegate?.handleNoBiometryFaceIDAuthorization()
            }
    }
    
    func requestAuthorization() {
        print("Authorization")
    }
}
