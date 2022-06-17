//
//  AuthorizationServiceDelegate.swift
//  FileManager
//
//  Created by Екатерина Неделько on 14.06.22.
//

protocol AuthorizationServiceDelegate: AnyObject {
    func handlePasswordIDAutorization(handler: @escaping (String?) -> Void)
    func handlePasswordSetting(handler: @escaping (String) -> Void)
}
