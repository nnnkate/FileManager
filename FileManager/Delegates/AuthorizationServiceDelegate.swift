//
//  AuthorizationServiceDelegate.swift
//  FileManager
//
//  Created by Екатерина Неделько on 14.06.22.
//

protocol AuthorizationServiceDelegate {
    func handleErrorFaceIDAuthorization()
    func handleNoBiometryFaceIDAuthorization()
    func handlePasswordIDAutorization(handler: @escaping (String?) -> Void)
}
